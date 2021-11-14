ActiveAdmin.register MasterList do
  menu priority: 6
  permit_params :user_id, :share_capital, :withdrawal, :balance, :membership_fee, :consolidation, :status
  
  form do |f|
    f.input :image, as: :file
    f.input :user
    f.input :consolidation
    f.input :status
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name, sortable: :user_id do |master_list|
      master_list.user
    end
    column :share_capital do |master_list|
      format_currency master_list.paid_share_capital
    end
    column "Withdrawal of SC", :share_capital do |master_list|
      format_currency master_list.withdrawal_of_sc
    end
    
    column "Balance of SC", :share_capital do |master_list|
      format_currency master_list.balance_of_share_capital
    end

    column "Membership Fee", :share_capital do |master_list|
      format_currency master_list.paid_membership_fee
    end

    column "Consolidation", :share_capital do |master_list|
      format_currency master_list.paid_consolidation
    end

    column "Status of Shared Capital", :share_capital do |master_list|
      master_list.status_of_share_capital
    end

    column "Status of Membership Fee", :share_capital do |master_list|
      master_list.status_of_membership_fee
    end

    column "Status of Consolidation", :share_capital do |master_list|
      master_list.status_of_consolidation
    end
    actions
  end 

  show do
    panel "Master List information" do
      attributes_table_for master_list do
        row :name do
          master_list.user
        end
        row "Paid Share Capital", :share_capital do
          format_currency master_list.paid_share_capital
        end
      
        row "Withdrawal of SC", :share_capital do
          format_currency master_list.withdrawal_of_sc
        end
        
        row "Balance of SC", :share_capital do
          format_currency master_list.balance_of_share_capital
        end
    
        row "Membership Fee", :share_capital do
          format_currency master_list.paid_membership_fee
        end
    
        row "Consolidation", :share_capital do
          format_currency master_list.paid_consolidation
        end
    
        row "Status of Shared Capital", :share_capital do
          master_list.status_of_share_capital
        end
    
        row "Status of Membership Fee", :share_capital do
          master_list.status_of_membership_fee
        end
    
        row "Status of Consolidation", :share_capital do
          master_list.status_of_consolidation
        end
        row "Status of Consolidation", :share_capital do
          status_tag master_list.membership
        end
      end 
    end
    br
    panel "Working Files" do
      table_for master_list.working_files do
        column :id do |working_file|
          link_to working_file.id, admin_working_file_path(working_file)
        end
        column :or_no
        column :or_date, sortable: :or_date do |working_file|
          format_date working_file.or_date
        end
        column :master_list
        column :amount_paid, sortable: :amount do |working_file|
          format_currency working_file.amount
        end
        column :particular do |working_file|
          status_tag working_file.particular
        end
      end
    end
  end
end
