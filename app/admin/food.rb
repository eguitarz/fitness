ActiveAdmin.register Food do
  menu priority: 2

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  permit_params :name, :description, :category, :food_group, :barcode, :barcode_type, :brand, :calories, :total_fat,
                :saturated_fat, :trans_fat, :polyunsaturated_fat, :omega_6, :omega_3, :protein,
                :monounsaturated_fat, :cholesteral, :sodium, :potassium, :total_carbohydrates,
                :dietary_fiber, :sugars, :vitamin_a, :vitamin_b, :calcium, :iron, :caffeine, :serving_size,
                :serving_size_type, :location, :is_edited, :created_at, :user_ip, :user_email, :is_edited
  index do
    selectable_column
    id_column
    column :is_edited
    column :name
    column :description
    column :category
    column :food_group
    column :barcode
    column :barcode_typ
    column :brand
    column :calories
    column :total_fat
    column :saturated_fat
    column :trans_fat
    column :polyunsaturated_fat
    column :omega_6
    column :omega_3
    column :protein
    column :monounsaturated_fat
    column :cholesteral
    column :sodium
    column :potassium
    column :total_carbohydrates
    column :dietary_fiber
    column :sugars
    column :vitamin_a
    column :vitamin_b
    column :calcium
    column :iron
    column :caffeine
    column :serving_size
    column :serving_size_type
    column :serving_unit
    column :location
    column :total_carbohydrates
    column :updated_at
    column :created_at
    column :user_ip
    column :user_email
    actions
  end

  filter :is_edited
  filter :name
  filter :category
  filter :food_group
  filter :created_at

  batch_action :approve do |selection|
    Food.find(selection).each do |food|
      food.is_approved = true
      food.save
    end

    redirect_to :back
  end

  batch_action :disapprove do |selection|
    Food.find(selection).each do |food|
      food.is_approved = false
      food.save
    end

    redirect_to :back
  end

end
