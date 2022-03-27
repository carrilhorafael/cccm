class Church::Base
  include Interactor

  def church
    context.church
  end

  def performer
    context.performer
  end

  def check_authorization
    context.fail!(error: "Somente o pastor presidente ou um líder da igreja podem executar essa ação") unless church.can_edit?(performer)
  end

  def church_params
    context.church_params
  end
end
