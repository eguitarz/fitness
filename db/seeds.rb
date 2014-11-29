# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times.each do
  Food.create({
    name: Faker::Lorem.word,
    description: Faker::Lorem.paragraph,
    category: Faker::Number.number(1),
    food_group: Faker::Number.number(1),
    # barcode: Faker::Number.number(12),
    barcode: 123456789222,
    brand: Faker::Company.name,
    calories: Faker::Number.number(rand(3) + 1),
    total_fat: Faker::Number.number(rand(2) + 1),
    saturated_fat: Faker::Number.number(rand(2) + 1),
    trans_fat: Faker::Number.number(rand(2) + 1),
    polyunsaturated_fat: Faker::Number.number(rand(2) + 1),
    omega_6: Faker::Number.number(rand(2) + 1),
    omega_3: Faker::Number.number(rand(2) + 1),
    monounsaturated_fat: Faker::Number.number(rand(2) + 1),
    cholesteral: Faker::Number.number(rand(2) + 1),
    sodium: Faker::Number.number(rand(2) + 1),
    potassium: Faker::Number.number(rand(2) + 1),
    total_carbohydrates: Faker::Number.number(rand(2) + 1),
    dietary_fiber: Faker::Number.number(rand(2) + 1),
    sugars: Faker::Number.number(rand(2) + 1),
    vitamin_a: Faker::Number.number(rand(2) + 1),
    vitamin_b: Faker::Number.number(rand(2) + 1),
    calcium: Faker::Number.number(rand(2) + 1),
    iron: Faker::Number.number(rand(2) + 1),
    serving_size: Faker::Number.number(rand(1) + 1),
    serving_size_type: 1,
    is_mergeable: false,
    location: Faker::Address.country,
    user_ip: '10.10.10.4'
  })
end