ActiveAdmin.register User do
  menu parent: "Customer", priority: 10

  filter :first_name
  filter :last_name
  filter :email

  permit_params :email, 
                :username, 
                :user_type, 
                :contact_number, 
                :first_name, 
                :middle_name, 
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
                :pag_ibig,
                :address


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
    column "Name", :first_name do |user|
      user.name
    end
    column :email
    column :contact_number
    # column :user_type do |user|
    #   status_tag user.user_type
    # end
    actions
  end   
  
  form do |f|  
    f.semantic_errors *f.object.errors.keys
    f.input :image, as: :file

    f.input :username
    f.input :contact_number
    f.input :address
    f.input :first_name
    f.input :middle_name
    f.input :last_name
    f.input :email
    # f.input :user_type
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
                row :address 
                row :first_name 
                row :middle_name 
                row :last_name 
                row :gender 
                row :birthday 
                # row :user_type do 
                #   status_tag user.user_type
                # end
               
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

    
    panel "Order history" do
      table_for resource.orders do
        column :reference_number do |item|
          link_to item.reference_number, admin_order_path(item)
        end
        column :user do |order|
          link_to order.user.name, admin_user_path(order.user)
        end
        # column :quantity do |item|
        #   item.order_items.where(product_id: resource.id).first&.quantity
        # end
        column :status do |item|
          status_tag item.status
        end
        column :created_at
        column :price do |item|
          format_currency item.price
        end
      end
    end

  end

end
