ActiveAdmin.register AdminUser, as: "Admins" do
  config.filters = false 
  menu priority: 11
  permit_params :email, :name, :role, :status, :password, :password_confirmation, :image, :address

  index do
    selectable_column
    column :email
    column :name
    column :role
    column :status do |user|
      status_tag user.status
    end
    column :created_at
    actions
  end

  # filter :email
  # filter :role, as: :select
  # filter :status, as: :select
  # filter :current_sign_in_at
  # filter :sign_in_count
  # filter :created_at

  form do |f|
    f.inputs do
      f.input :image, as: :file
      f.input :email
      f.input :name
      f.input :address
      f.input :role
      f.input :status
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    panel "General Information" do
      attributes_table_for resource do
        row :email
        row :name
        row :address
        row :role
        row :status
        row :created_at
        row :updated_at
      end
    end
  end

end
