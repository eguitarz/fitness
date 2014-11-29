class AddIsMegeableToFood < ActiveRecord::Migration
  def change
    add_column :foods, :is_mergeable, :boolean, default: false
  end
end
