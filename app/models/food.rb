class Food < ActiveRecord::Base
  scope :recent, ->(num) { order('created_at DESC').limit(num) }
  scope :approved_count, -> { where(is_approved: true).count }

  def self.search(query=nil)
    if query.present?
      search_length = query.split.length
      result = Food.where [(['name LIKE ?'] * search_length).join(' AND ')] + query.split.map { |name| "%#{name}%" }
    else
      # self.all
    end
  end
end
