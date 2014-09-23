class Food < ActiveRecord::Base
  scope :approved, -> { where(is_approved: true) }
  scope :recent, ->(num) { order('created_at DESC').limit(num) }
  scope :approved_count, -> { where(is_approved: true).count }

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, length: { maximum: 3000 }
  validates :barcode, length: { maximum: 15 }
  validates :brand, length: { maximum: 100 }
  validates :location, length: { maximum: 50 }

  def self.search(query=nil, range=nil)
    range_start, range_end = parse_range range
    foods = nil

    if query.present?
      search_length = query.split.length
      sqls = []
      ['name', 'description'].each { |col| 
        search_length.times.each { sqls << "#{col} LIKE ?" }
      }
      keywords = query.split
      like_keywords = keywords.map{|keyword| "%#{keyword}%"}
      foods = Food.approved.where( [sqls.join(' OR ')] + like_keywords*2 )
      foods = filter_no_alphabet_before_keyowrds(foods, keywords)
    else
      foods = Food.approved
    end

    { total_hits: foods.size, data: foods[range_start..range_end] }
  end

  def self.barcode(barcode, range=nil)
    range_start, range_end = parse_range(range)
    foods = nil

    begin
      foods = Food.approved.where(barcode: barcode)
    rescue
      foods = []
    end

    { total_hits: foods.size, data: foods[range_start..range_end] }
  end

  private
  def self.parse_range(range)
    begin
      range_start, range_end = range.split(':')
      range_start = range_start.to_i
      range_end = range_end.to_i
    rescue
      range_start = 0
      range_end = 20
    end
    [range_start, range_end]
  end

  def self.filter_no_alphabet_before_keyowrds(foods, keywords)
    result = []
    pattern = keywords.map{|k| "(#{k})"}.join('|')
    result = foods.select do |food|
      (/^([A-Za-z\d]*\s+)?#{pattern}/i =~ food.name || /^([A-Za-z\d]*\s+)?#{pattern}/i =~ food.description) != nil
    end
    result
  end
end
