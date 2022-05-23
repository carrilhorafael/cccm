class User::Reset < User::Base

  def call
    context.fail!(errors: "Operação invalida sem a chave de acesso") unless context.key
    find_user
    check_consistency
    update_password
    validate_model
    user.save!
    call_login
  end

  private

  def find_user
    context.user = User.find_by(validation_token: context.key)
  end

  def check_consistency
    context.fail!(errors: error_message(:without_access)) unless user.has_access?
    context.fail!(errors: error_message(:token_invalid)) if Time.zone.now > user.validation_token_sent_at + 8.hours
  end

  def update_password
    user.password = context.password
    user.password_confirmation = context.password_confirmation
    user.validation_token = nil
    user.validation_token_sent_at = nil
  end

  def call_login
    context.token = User::Login.call(user: user).token
  end
end
