class Proselyte::Base
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

  def proselyte_params
    context.proselyte_params
  end
end
