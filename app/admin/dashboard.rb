ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }
  # menu false

  controller do
    # before_action :redirect_customer

    # def redirect_customer
    #   redirect_to admin_users_path
    # end

  end

  content title: proc { I18n.t("active_admin.dashboard") } do
    
    
    columns do
      column do
        panel "Product with low stocks" do
          ul do
            Product.order(stocks: :desc).map do |product|
              li link_to("#{product.name} (#{product.stocks} items)", admin_product_path(product))
            end
          end
        end
      end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    end
  end # content
end
