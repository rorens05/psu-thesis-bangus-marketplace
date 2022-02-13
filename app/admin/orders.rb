ActiveAdmin.register Order do
  config.filters = false 
  permit_params :user_id, :status, :note, :contact_number, :address

  index do
    column :reference_number do |item|
      link_to item.reference_number, admin_order_path(item)
    end
    column :user
    column :address
    column :status do |item|
      status_tag item.status
    end
    actions
  end

  show do
    panel "Order Details" do
      attributes_table_for resource do
        row :reference_number
        row :user
        row :address
        row :status do |item|
          status_tag item.status
        end
        row :note
        row :contact_number
        row :price do |item|
          format_currency item.price
        end
        row :created_at
        row :updated_at
      end
    end
    panel "Order Items" do
      table_for resource.order_items do
        column :product do |item|
          link_to item.product.name, admin_product_path(item.product)
        end
        column :quantity
        column :price do |item|
          format_currency item.price
        end
      end
    end
  end
end
