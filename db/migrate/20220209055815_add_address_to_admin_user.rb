class AddAddressToAdminUser < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :address, :string
  end
end
