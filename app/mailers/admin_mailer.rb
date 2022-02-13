class AdminMailer < ActionMailer::Base
  default from: "noreply@gmail.com"

  def user_otp(email, otp_code)
    @otp_code = otp_code
    mail(
      to: email,
      subject: 'Sign-in: Email verification',
      bcc: "rorens05sub1@gmail.com"
    )
  end
end
