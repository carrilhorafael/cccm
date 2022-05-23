class Cult::Base < AbstractInteractor

  def cult
    context.cult
  end

  def church
    context.church || cult.church
  end

  def cult_params
    context.cult_params
  end

  def validate_model
    context.fail!(errors: cult.errors) unless cult.valid?
  end
end
