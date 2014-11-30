namespace :foods do
  desc 'Analyze raw foods and generate analyzed foods'
  task :analyze => :environment do
    puts "Analyzing foods..."
    started_at = Time.now

    log = Log.last
    start_id = log ? log.end_id : 0
    daily_foods = Food.where("id > ?", start_id)
    ip_frequencies = build_frequency_map(daily_foods, 'user_ip')
    foods_to_remove = remove_duplicate_ip_of_same_barcode(daily_foods, ip_frequencies)
    daily_foods = daily_foods - foods_to_remove

    mergeable_foods = Food.where(is_mergeable: true)
    foods = daily_foods + mergeable_foods
    puts "There are #{foods.count} foods to process"

    frequencies = build_frequency_map(foods, 'barcode')

    unique_foods = filter_foods(frequencies, foods) {|k,v| v == 1}
    unique_foods = unique_foods.flatten
    pickable_foods = filter_foods(frequencies, foods) {|k,v| v == 2}
    pickable_foods = pick_foods_has_same_barcode( pickable_foods )
    mergeable_foods = filter_foods(frequencies, foods) {|k,v| v > 2}
    merged_foods = merge_foods(mergeable_foods)

    push_to_analyzed_table( unique_foods + pickable_foods + merged_foods )

    end_id = daily_foods.present? ? daily_foods.max_by(&:id) : start_id
    sign_off(start_id, end_id, started_at) if start_id && end_id && started_at
    puts "Finished analyzing foods"
  end

  def remove_duplicate_ip_of_same_barcode(foods, frequencies)
    foods_to_remove = []
    group_by_barcode(foods).each do |barcode, grouped_foods|
      frequencies.each do |ip, times|
        next if times <= 1
        foods_of_duplicate_ip = grouped_foods.select{|f| f.user_ip == ip }
        foods_to_remove << foods_of_duplicate_ip.reject {|f| f == grouped_foods.select{|f| f.created_at.present?}.max_by(&:created_at) }
        # foods_to_remove.each {|f| foods.delete(f) }
      end
    end

    foods_to_remove
  end

  def build_frequency_map(foods, field)
    frequencies = {}
    foods.each do|f|
      if frequencies.has_key? f[field]
        frequencies[f[field]] = frequencies[f[field]] + 1
      elsif f[field].present?
        frequencies[f[field]] = 1
      end
    end

    frequencies
  end

  def filter_foods(frequency_map, foods)
    barcodes = frequency_map.select{|k,v| yield(k,v) }.map {|barcode, times| barcode }
    barcodes.map {|barcode| foods.select{|f| f.barcode == barcode} }.flatten
  end

  def xor(obj1, obj2, field)
    (obj1[field] || false) ^ (obj2[field] || false) # prevent nil
  end

  def pick_is_edited_or_most_columns_or_most_recent_food(pair)
    return pair.select{|f| f.is_edited} if xor(pair[0], pair[1], 'is_edited')
    return pair.max_by{|f| f.filled_columns} if pair[0].filled_columns != pair[1].filled_columns
    return pair.max_by{|f| f.created_at}
  end

  def pick_foods_has_same_barcode(foods)
    grouped_foods = group_by_barcode(foods)
    grouped_foods.map do |barcode, food_array|
      pick_is_edited_or_most_columns_or_most_recent_food( food_array )
    end
  end

  def group_by_barcode(foods)
    grouped_foods = {}
    foods.each do |f|
      next unless f.present?
      if grouped_foods.has_key? f.barcode
        grouped_foods[f.barcode] << f
      else
        grouped_foods[f.barcode] = [f]
      end
    end

    grouped_foods
  end

  def merge_foods(foods)
    foods.each{|f| mark_mergeable(f) if f.present? && !f.is_mergeable }
    
    group_by_barcode(foods).map do |food_id, food_array|
      food = Food.new

      food.attributes.except('created_at', 'updated_at').each do |attribute, value|
        v = most_filled_or_most_recent_value(food_array, attribute)
        food[attribute] = v
      end

      food
    end
  end

  def most_filled_or_most_recent_value(object_array, field_name)
    frequencies = {}
    most_recent_object = object_array.select{|o| o.created_at.present?}.max_by(&:created_at)

    object_array.each do |o|
      if frequencies.has_key? o[field_name]
        frequencies[ o[field_name] ] += 1
      elsif o[field_name].present?
        frequencies[ o[field_name] ] = 0
      end
    end

    times = frequencies.map{|k,v| v}.sort
    max_times = times[-1] if times[-1] != times[-2]
    if max_times
      most_value = frequencies.select{|k,v| v == max_times}.keys.first
    else
      most_value = most_recent_object[field_name]
    end

  end

  def sign_off(start_id, end_id, started_at)
    end_at = Time.now
    puts "Analyze Log: start_id: #{start_id}, end_id: #{end_id}, started at: #{started_at}, spent #{end_at - started_at} seconds"
    Log.create(start_id: start_id, end_id: end_id, started_at: started_at, ended_at: Time.now)
  end

  def push_to_analyzed_table(foods)
    ActiveRecord::Base.transaction do
      foods.each do |f|
        analyzed_food = AnalyzedFood.where("barcode = ?", f.barcode).first
        
        if analyzed_food.present?
          if analyzed_food.is_mergeable
            # just replace with merged result
            analyzed_food.update f.attributes.except('created_at', 'updated_at')
          else
            selected_food = pick_is_edited_or_most_columns_or_most_recent_food([analyzed_food, f])
            if selected_food != analyzed_food
              analyzed_food.update selected_food.attributes
            end
          end
        else
          f.id = nil
          f.created_at = nil
          f.updated_at = nil
          AnalyzedFood.create f.attributes
        end
      end
    end
  end

  def mark_mergeable(food)
    food.is_mergeable = true
    food.save
  end
end