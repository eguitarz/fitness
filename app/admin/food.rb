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
  permit_params :is_approved, :name, :category, :food_group, :barcode, :total_fat, :carbs, :fiber, :protein

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
