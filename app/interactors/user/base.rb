class User::Base < AbstractInteractor

  def user
    context.user
  end

  def church
    user&.church || context.church
  end

  def filter
    user&.filter || context.filter
  end

  def skip_mailer_notification
    context.skip_mailer_notification
  end

  def validate_model
    context.fail!(errors: user.errors) unless user.valid?
  end

  def user_params
    context.user_params
  end
end
