class Ministery::Base < AbstractInteractor

  def ministery
    context.ministery
  end

  def church
    context.church || ministery.church
  end

  def ministery_params
    context.ministery_params
  end

  def validate_model
    context.fail!(errors: ministery.errors) unless ministery.valid?
  end
end
