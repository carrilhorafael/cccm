class Church::Base < AbstractInteractor

  def church
    context.church
  end

  def check_authorization
    context.fail!(errors: error_message(:president_pastor_required)) unless performer.president_pastor?
  end

  def validate_model
    context.fail!(errors: church.errors) unless church.valid?
  end

  def church_params
    context.church_params
  end
end
