class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.integer :points, null: false, default: 0
      
      # ext
      t.string :description
      t.integer :serving_size_numerator
      t.integer :serving_size_denominator
      t.string :serving_size_unit, default: "servings"
      t.boolean :is_fruit_or_vegetable, default: false
      t.boolean :is_using_nutrition_info, default: false
      t.float :nutrition_fat, default: 0
      t.float :nutrition_carbs, default: 0
      t.float :nutrition_fiber, default: 0
      t.float :nutrition_protein, default: 0
      t.string :nutrition_unit, default: "grams"

      #server side
      t.string :remote_ip
      t.timestamps
    end
  end
end
