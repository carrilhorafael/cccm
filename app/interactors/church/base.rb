class Church::Base
  include Interactor

  def church
    context.church
  end

  def performer
    context.performer
  end
end
