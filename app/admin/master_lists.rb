ActiveAdmin.register MasterList do
  menu priority: 6

  permit_params :user_id, :share_capital, :withdrawal, :balance, :membership_fee, :consolidation, :status
  
end
