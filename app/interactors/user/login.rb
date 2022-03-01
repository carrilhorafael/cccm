class User::Login < User::Base

  def call
    find_user
    check_consistency
    authenticate_user
    generate_token
    update_last_login_at
  end

  private

  def find_user
    context.user = User.find_by!(email: context.email)
  end

  def check_consistency
    context.fail!(error: "Você não tem acesso ao sistema") if user.has_access?
  end

  def authenticate_user
    context.fail!(error: "Senha incorreta") unless user.authenticate(context.password)
  end

  def generate_token
    context.token = JsonWebToken::Base.encode(user.id)
  end

  def update_last_login_at
    user.update!(last_time_logged_at: Time.now)
  end
end
