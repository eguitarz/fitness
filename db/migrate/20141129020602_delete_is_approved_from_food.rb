class DeleteIsApprovedFromFood < ActiveRecord::Migration
  def change
    remove_column :foods, :is_approved
  end
end
