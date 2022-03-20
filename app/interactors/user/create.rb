class User::Create < User::Base

  def call
    check_authorization
    build_user
    user.set_default_password
    validate_model
    ActiveRecord::Base.transaction do
      user.save!
      grant_new_access if access_params[:should_have_access]
      create_default_filter
    end

  end

  private

  def check_authorization
    context.fail!(error: "Você não pode cadastrar um membro com este nível de permissão") unless church.can_edit?(performer)
  end

  def build_user
    context.user = church.users.build(user_params)
    user.title ||= "Membro"
  end

  def validate_model
    context.fail!(error: user.errors.full_messages.join(". ")) unless user.valid?
  end

  def grant_new_access
    action = User::GrantAccess.call(
      user: user,
      performer: performer,
      is_leader: access_params[:is_leader],
      skip_mailer_notification: skip_mailer_notification
    )
  end

  def create_default_filter
    action = Filter::Create.call(performer: user)

    unless action.success?
      context.fail!(error: action.error)
    end
  end

  def user_params
    context.user_params
  end

  def access_params
    context.access_params || {}
  end
end
