class FoodsController < ApplicationController
  def new
    render status: 200
  end

  def search
    query = params[:query]
    query.strip! unless query.empty?
    results = Food.search(query)
    render json: {total_hits: results.count, results: results}
  end

end
