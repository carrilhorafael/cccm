class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.grant_access.subject
  #
  def grant_access
    @user = User.find(params[:user_id])
    @performer = User.find(params[:performer_id])

    mail(to: @user.email, subject: "Você foi adicionado ao sistema da CCCM")
  end
end
