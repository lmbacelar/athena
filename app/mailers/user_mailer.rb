class UserMailer < ActionMailer::Base
  default from: 'athena@i-dea.tk'

  # Subject is set in I18n file at config/locales/en.yml
  #   en.user_mailer.password_reset.subject
  def password_reset(user)
    @user = user
    mail to: user.email
  end
end
