module UsersOtp
  module Sessions
    class OtpAuthenticationsController < ApplicationController
      # prepend_before_action -> { authenticate_admin_user!(force: true) }
      # skip_before_action :require_no_authentication

      def new
        return unless otp_sent?
        current_user.send_otp_mail
        session[:otp_invalid_after] = Time.zone.now.advance(minutes: 1)
      end

      def create
        if current_user.authenticate_otp(params[:otp], drift: 1.minutes)
          current_user.touch(:otp_auth_at)
          redirect_to root_path
        else
          # set invalid OTP flash message
          flash.alert = "Invalid OTP."
          render :new
        end
      end

      private

      def otp_sent?
        return true if session[:otp_invalid_after].nil?

        session[:otp_invalid_after] < Time.zone.now
      end
    end
  end
end
