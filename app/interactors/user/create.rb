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

  def build_user
    context.user = church.users.build(user_params)
  end

  def grant_new_access
    action = User::GrantAccess.call(
      user: user,
      performer: performer,
      is_leader: access_params[:is_leader],
      skip_mailer_notification: skip_mailer_notification
    )

    context.fail!(errors: action.errors) unless action.success?
  end

  def create_default_filter
    action = Filter::Create.call(performer: user, filter_params: default_filter_params)

    unless action.success?
      context.fail!(errors: action.errors)
    end
  end

  def default_filter_params
    { source: 'users' }
  end

  def access_params
    context.access_params || {}
  end
end
