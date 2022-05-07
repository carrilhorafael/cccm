class Cult::Base
  include Interactor

  def performer
    context.performer
  end

  def cult
    context.cult
  end

  def church
    context.church || cult.church
  end

  def cult_params
    context.cult_params
  end

  def check_authorization
    context.fail!(error: "Você não pode executar essa ação") unless church.can_edit?(performer)
  end

  def validate_model
    context.fail!(error: cult.errors.full_messages.join(". ")) unless cult.valid?
  end
end
