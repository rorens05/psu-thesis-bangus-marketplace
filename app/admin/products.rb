ActiveAdmin.register Product do
  permit_params :image, :name, :description, :price, :wholesale_price, :wholesale_minimum_quantity, :stocks
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
    f.input :price
    f.input :wholesale_price
    f.input :wholesale_minimum_quantity
    f.input :stocks
    f.actions
  end

  show do
    panel "Product details" do
      columns do
        column span: 3 do
          attributes_table_for product do
            row :name
            row :description
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
  end
end
