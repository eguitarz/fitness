# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
foods = Food.create([
  {
    name: "Apple",
    points: 7,
    barcode: 119123434344,
    description: "Just an edible apple.",
    serving_size_numerator: 5,
    serving_size_denominator: 4,
    serving_size_unit: "servings",
    is_fruit_or_vegetable: true,
    is_using_nutrition_info: true,
    nutrition_fat: 2.5,
    nutrition_carbs: 13.1,
    nutrition_fiber: 0.5,
    nutrition_protein: 0,
    nutrition_unit: "grams",
    is_enabled: true
  },
  {
    name: "Banana",
    points: 3,
    barcode: 119123434345,
    description: "Just an edible banana.",
    serving_size_numerator: 1,
    serving_size_denominator: 4,
    serving_size_unit: "servings",
    is_fruit_or_vegetable: true,
    is_using_nutrition_info: true,
    nutrition_fat: 3.5,
    nutrition_carbs: 0,
    nutrition_fiber: 0,
    nutrition_protein: 0,
    nutrition_unit: "grams",
    is_enabled: true
  },
  {
    name: "Cat",
    points: 24,
    barcode: 219123434345,
    description: "Just an edible cat.",
    serving_size_numerator: 10,
    serving_size_denominator: 1,
    serving_size_unit: "oz",
    is_fruit_or_vegetable: false,
    is_using_nutrition_info: true,
    nutrition_fat: 203.5,
    nutrition_carbs: 0,
    nutrition_fiber: 0,
    nutrition_protein: 100,
    nutrition_unit: "grams",
    is_enabled: false
  }
])