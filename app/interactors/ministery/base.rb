class Ministery::Base
  include Interactor

  def ministery
    context.ministery
  end

  def church
    context.church
  end

  def performer
    context.performer
  end
end
