ActiveAdmin.register ProductStock do
  config.filters = false 
  menu parent: "Products", label: "Stocks"

  permit_params :product_id, :quantity

  before_create do 
    resource.admin_user_id = current_admin_user.id
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.input :product
    f.input :quantity
    f.actions
  end

  index do
    selectable_column
    column :product
    column :quantity
    column :created_by do |item|
      item.admin_user
    end
    actions
  end

  show do
    attributes_table do
      row :product
      row :quantity
      row :created_by do |item|
        item.admin_user
      end
      row :created_at
      row :updated_at
    end
  end

end
