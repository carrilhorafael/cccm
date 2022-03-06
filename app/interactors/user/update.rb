class User::Update < User::Base

  def call
    check_authorization
    assign_attributes
    validate_model
    user.save!
  end

  private

  def check_authorization
    context.fail!(error: "Você não apagar usuários do sistema com esse nível de permissão") unless context.church.can_edit?(performer)
  end

  def assign_attributes
    user.assign_attributes(context.user_params)
  end

  def validate_model
    context.fail!(error: user.errors.full_messages.join(". ")) unless user.valid?
  end
end
