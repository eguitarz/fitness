class AddIsEditedToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :is_edited, :boolean
  end
end
