class FoodsController < ApplicationController
   skip_before_filter :verify_authenticity_token

  def create
    food = Food.new params.permit(
      :name, :description, :category, :food_group, :barcode, :barcode_type, :brand, :calories, :total_fat, :saturated_fat,
      :trans_fat, :polyunsaturated_fat, :omega_6, :omega_3, :protein, :monounsaturated_fat, :cholesteral,
      :sodium, :potassium, :total_carbohydrates, :dietary_fiber, :sugars, :vitamin_a, :vitamin_b,
      :calcium, :iron, :caffeine, :serving_size, :serving_size_type, :location, :user_ip, :user_email,
      :is_edited
    )

    if food.save
      render nothing: true
    else
      render json: {errors: food.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def search
    query = sanitize_url params[:query]
    results = AnalyzedFood.search(query, params[:range])
    render json: {total_hits: results[:total_hits], results: results[:data]}
  end

  def barcode
    barcode = params[:barcode]
    results = AnalyzedFood.barcode(barcode, params[:range])
    render json: {total_hits: results[:total_hits], results: results[:data]}
  end

  private 
  def sanitize_url(url)
    if url.present?
      url.strip!
      url = URI.unescape(url)
    end
    url
  end

end
