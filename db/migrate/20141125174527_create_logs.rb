class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :start_id
      t.integer :end_id
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
