class Proselyte::Base < AbstractInteractor

  def proselyte
    context.proselyte
  end

  def church
    cult.church
  end

  def cult
    context.cult
  end

  def proselyte_params
    context.proselyte_params
  end

  def validate_model
    context.fail!(errors: proselyte.errors) unless proselyte.valid?
  end
end
