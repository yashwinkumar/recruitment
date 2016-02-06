class UserMailer < ApplicationMailer
  include SendGrid
  default from: "recruitment@gmail.com"
  layout 'mailer'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Recruitment')
  end
end
