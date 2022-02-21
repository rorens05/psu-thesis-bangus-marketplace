class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :middle_name, :birthday, :gender, :address, :contact_number, :image, 
      :sss,
      :tin,
      :philhealth,
      :user_type,
    ])
  end

  def authenticate_current_admin_user_with_otp!

    return if controller_name == "otp_authentications" || 
              ActiveAdmin::Devise.controllers.keys.include?(controller_name.to_sym) || 
              current_admin_user.otp_authenticated?

    redirect_to(admin_otp_page_path)
  end


  def authenticate_current_user_with_otp!

    return if current_user.blank? || controller_name == "otp_authentications" || 
              devise_controller? ||
              current_user&.otp_authenticated?

    redirect_to(user_otp_page_path)
  end


end
