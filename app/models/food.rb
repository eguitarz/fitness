class Food < ActiveRecord::Base
  scope :recent, ->(num) { order('created_at DESC').limit(num) }
  scope :approved_count, -> { where(is_approved: true).count }
end
