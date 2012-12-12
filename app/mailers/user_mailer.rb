class UserMailer < ActionMailer::Base
  default from: "no-reply@funny.org"

  def password_reset(user)
    @user = user
    mail(to: user.email) 
  end
end
