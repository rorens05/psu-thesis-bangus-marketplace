ActiveAdmin.register Product do
  config.filters = false 
  permit_params :image, :name, :description, :price, :wholesale_price, :wholesale_minimum_quantity, :stocks, :category
  menu parent: "Products"

  index do
    selectable_column
    column "Photo" do |product|
      link_to admin_product_path(product) do
        image_tag product.image.attached? ? product.image : "/images/no-image.png", class: 'product-index-image'
      end
    end
    column "Name", sortable: :name do |product|
      product.name
    end
    column :price do |product|
      format_currency product.price
    end
    column :category do |product|
      status_tag product.category || "N/A"
    end
    column :wholesale_price do |product|
      format_currency product.wholesale_price
    end
    actions
  end

  form do |f|  
    f.semantic_errors *f.object.errors.keys
    f.input :image, as: :file
    f.input :name
    f.input :description
    f.input :category
    f.input :price
    f.input :wholesale_price
    f.input :wholesale_minimum_quantity
    f.actions
  end

  show do
    panel "Product details" do
      columns do
        column span: 3 do
          attributes_table_for product do
            row :name
            row :description
            row :category do |product|
              status_tag product.category || "N/A"
            end
            row :price do 
              format_currency product.price 
            end
            row :wholesale_price do 
              format_currency product.wholesale_price 
            end
            row :wholesale_minimum_quantity
            row :stocks
            row :created_at
            row :updated_at
          end
        end
        if product.image.attached?
          column span: 1 do
            image_tag product.image, class: 'product-show-image'         
          end
        end
      end
    end

    panel "Order history" do
      table_for resource.orders do
        column :reference_number do |item|
          link_to item.reference_number, admin_order_path(item)
        end
        column :user do |order|
          link_to order.user.name, admin_user_path(order.user)
        end
        column :quantity do |item|
          item.order_items.where(product_id: resource.id).first&.quantity
        end
        column :status do |item|
          status_tag item.status
        end
        column :created_at
      end
    end

    panel "Stocks history" do
      table_for resource.product_stocks do
        column :created_by do |item|
          item.admin_user
        end
        column :quantity
        column :created_at
        
      end
    end
  end
end
