ActiveAdmin.register User do
  menu parent: "Customer", priority: 10

  permit_params :email, 
                :username, 
                :user_type, 
                :contact_number, 
                :first_name, 
                :last_name, 
                :gender, 
                :birthday, 
                :role, 
                :status,
                :password,
                :password_confirmation,
                :image,
                :country,
                :region_id,
                :province_id,
                :city_id,
                :sss,
                :tin,
                :philhealth,
                :pag_ibig


  member_action :verify, method: :post do
    resource.verified_at = DateTime.now
    resource.save
    redirect_to resource_path, notice: "Verified"
  end

  member_action :logged_out, method: :post do
    resource.token = nil
    resource.save
    UserChannel.broadcast_to(
        resource,
        { type: "LOGOUT", token: resource.token}
      )
    redirect_to resource_path, notice: "User successfully logged out"
  end
  
  member_action :unverify, method: :post do
    resource.verified_at = nil
    resource.save
    redirect_to resource_path, notice: "Unveried"
  end

  index do
    selectable_column
    id_column
    column "Name", :first_name do |user|
      user.name
    end
    column :email
    column :contact_number
    column :user_type do |user|
      status_tag user.user_type
    end
    actions
  end   
  
  form do |f|  
    f.semantic_errors *f.object.errors.keys
    f.input :image, as: :file

    f.input :username
    f.input :contact_number
    f.input :first_name
    f.input :last_name
    f.input :email
    f.input :user_type
    f.input :gender
    f.input :birthday, as: :date_picker
    f.input :status
    
    f.input :password
    f.input :password_confirmation
    f.actions
  end

  show do
    panel user.name do
      tabs do
        tab '' do
          columns do
            column span: 3 do
              attributes_table_for user do
                row :id
                row :email
                row :username
                row :contact_number 
                row :first_name 
                row :last_name 
                row :gender 
                row :birthday 
                row :user_type do 
                  status_tag user.user_type
                end
               
              end
            end
            if user.image.attached?
              column do
                image_tag user.image, class: 'width-100'
              end
            end
          end
        end
       
      end
    end
  end

end
