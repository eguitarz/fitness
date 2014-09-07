ActiveAdmin.register Food do


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
  permit_params :is_enabled, :name, :points, :barcode, :nutrition_fat, :nutrition_carbs, :nutrition_fiber, :nutrition_protein

  index do
    selectable_column
    id_column
    column :is_enabled
    column :name
    column :points
    column :description
    column :created_at
    actions
  end

  filter :name
  filter :points
  filter :created_at

end
