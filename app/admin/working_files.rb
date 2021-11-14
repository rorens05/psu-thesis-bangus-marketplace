ActiveAdmin.register WorkingFile do
  permit_params :or_no, :or_date, :master_list_id, :particular, :member, :amount
  menu priority: 6
  
  form do |f|
    f.input :master_list
    f.input :or_no
    f.input :or_date, as: :date_picker
    f.input :particular
    f.input :amount
    f.actions
  end

  index do
    selectable_column
    id_column
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
    column :member do |working_file|
      status_tag working_file.member
    end
    actions
  end 

end
