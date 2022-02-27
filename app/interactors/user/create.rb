class User::Create < User::Base

  def call
    check_authorization
    build_user
    user.set_default_password
    validate_model
    user.save!
  end

  private

  def check_authorization
    context.fail!(error: "Você não pode cadastrar um membro com este nível de permissão") unless performer.is_admin?
  end

  def build_user
    context.user = User.new(user_params)
  end

  def validate_model
    context.fail!(error: user.errors.full_messages.join(". ")) unless user.valid?
  end

  def user_params
    context.user_params
  end
end
