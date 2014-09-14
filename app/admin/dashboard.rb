ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Foods" do
          ul do
            Food.recent(15).map do |food|
              li link_to(food.name, admin_food_path(food))
            end
          end
        end
      end

      column do
        panel "Food summary" do
          para "There are #{Food.count} foods created"
          para "There are #{Food.approved_count} foods enabled"
        end
      end
    end
  end # content
end
