class User::GrantAccess < User::Base

  def call
    check_authorization
    initialize_context
    update_user!
    send_access_notification if grant_new_access?
  end

  private

  def check_authorization
    context.fail!(error: "Operação invalida") if kind == 2
    context.fail!(error: "Somente o pastor presidente pode adicionar pastores") if kind == 1 && !performer.pastor_president?
    context.fail!(error: "Você não tem permissão para dar esse acesso") if kind == 0 && !performer.is_admin?
  end

  def initialize_context
    context.grant_new_access = user.member_without_access?
  end

  def grant_new_access?
    context.grant_new_access
  end

  def update_user!
    user.kind = kind
    if grant_new_access?
      user.access_garantied_at = Time.now
      user.validation_token = SecureRandom.alphanumeric(24)
      user.validation_token_sent_at = Time.now
    end
    user.save!
  end

  def kind
    context.kind
  end

  def send_access_notification
    UserMailer.with(performer_id: performer.id, user_id: user.id).grant_access.deliver_now
  end
end
