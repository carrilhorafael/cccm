class Filter::Base
  include Interactor

  def performer
    context.performer
  end

  def user
    performer
  end

  def filter
    context.filter || user.filter
  end
end
