class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    mail subject: I18n.t("auth.passwords.mailer.reset.subject"), to: user.email_address
  end
end
