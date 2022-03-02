class User::GrantAccess < User::Base

  def call
    check_authorization
    update_user
    user.save!
    send_access_notification
  end

  private

  def check_authorization
    context.fail!(error: "Você não dar acesso ao sistema com este nível de permissão") unless context.church.can_edit?(performer)
  end

  def grant_new_access?
    context.grant_new_access
  end

  def update_user
    user.access_garantied_at = Time.zone.now
    user.access_garantied_by = performer.name
    user.is_leader = is_leader
    user.validation_token = SecureRandom.alphanumeric(24)
    user.validation_token_sent_at = Time.zone.now
  end

  def is_leader
    context.is_leader || false
  end

  def send_access_notification
    UserMailer.with(performer_id: performer.id, user_id: user.id).grant_access.deliver_now
  end
end
