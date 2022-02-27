class User::Base
  include Interactor

  def performer
    context.performer
  end

  def user
    context.user
  end
end
