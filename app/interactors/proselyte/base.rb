class Proselyte::Base
  include Interactor

  def proselyte
    context.proselyte
  end

  def church
    cult.church
  end

  def cult
    context.cult
  end

  def performer
    context.performer
  end

  def proselyte_params
    context.proselyte_params
  end
end
