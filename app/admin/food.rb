ActiveAdmin.register Food do
  menu priority: 1

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
                :dietary_fiber, :sugars, :vitamin_a, :vitamin_b, :calcium, :iron, :serving_size,
                :serving_size_type, :location, :is_approved, :created_at
  index do
    selectable_column
    id_column
    column :is_approved
    column :name
    column :category
    column :food_group
    column :description
    column :created_at
    actions
  end

  filter :is_approved
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
