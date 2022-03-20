class User::Base
  include Interactor

  def performer
    context.performer
  end

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
end
