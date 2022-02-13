class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
         
  has_many :messages, dependent: :destroy
  
  has_one_attached :image

  enum status: ["Active", "Inactive"]
  enum role: ["Super Admin", "Admin"]

  def image_path
    return Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) if image.attached?
  end
  
  def password_required?
    return false
    super
  end
  
  OTP_AUTH_EXPIRES_IN = 24.hours
  has_one_time_password

  def send_otp_mail
    Rails.logger.info "Sending OTP mail to #{email}"
    Rails.logger.info "Sending OTP: #{otp}"
    AdminMailer.user_otp(email, otp_code).deliver_now
  end

  def otp_authenticated?
    return unless otp_auth_at?

    otp_auth_at + OTP_AUTH_EXPIRES_IN > Time.zone.now
  end

end
