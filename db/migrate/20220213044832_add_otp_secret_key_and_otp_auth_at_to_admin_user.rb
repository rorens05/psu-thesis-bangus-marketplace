class AddOtpSecretKeyAndOtpAuthAtToAdminUser < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :otp_secret_key, :string
    add_column :admin_users, :otp_auth_at, :timestamp
  end
end
