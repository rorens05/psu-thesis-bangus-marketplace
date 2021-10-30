class AddGovernmentInfoToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sss, :string
    add_column :users, :tin, :string
    add_column :users, :philhealth, :string
    add_column :users, :pag_ibig, :string
  end
end
