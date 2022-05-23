class Filter::Base < AbstractInteractor

  def user
    performer
  end

  def filter
    context.filter || user.filter
  end

  def filter_params
    context.filter_params
  end
end
