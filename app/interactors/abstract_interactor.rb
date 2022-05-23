class AbstractInteractor
  include Interactor

  def performer
    context.performer
  end

  def error_message(key)
    resource, action = self.class.name.downcase.split("::")
    { action => [ I18n.t("actions.#{resource}.#{action}.#{key}") ] }
  end

  def check_authorization
    context.fail!(errors: error_message(:forbidden)) unless church.can_edit?(performer)
  end
end
