ActiveAdmin.register MasterList do
  menu priority: 6

  permit_params :user_id, :share_capital, :withdrawal, :balance, :membership_fee, :consolidation, :status
  
  index do
    selectable_column
    id_column
    column :name, sortable: :user_id do |master_list|
      master_list.user
    end
    column :share_capital do |master_list|
      format_currency master_list.share_capital
    end
    column "Withdrawal of SC", :share_capital do |master_list|
      format_currency master_list.withdrawal
    end
    
    column "Balance of SC", :share_capital do |master_list|
      format_currency master_list.balance_of_share_capital
    end

    column "Membership Fee", :share_capital do |master_list|
      format_currency master_list.membership_fee
    end

    column "Consolidation", :share_capital do |master_list|
      format_currency master_list.consolidation
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


end
