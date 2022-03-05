class User::RevokeAccess < User::Base

  def call
    check_authorization
    revoke_access
  end

  private

  def check_authorization
    context.fail!(error: "Você não retirar acesso ao sistema com este nível de permissão") unless context.church.can_edit?(performer)
    context.fail!(error: "Você não pode tirar acesso de um pastor presidente") if user.president_pastor && !performer.president_pastor
  end

  def check_consistency
    context.fail!(error: "Esse usuário não tem acesso ao sistema") unless user.has_access?
  end

  def revoke_access
    user.set_default_password
    user.access_garantied_at = nil
    user.access_garantied_by = nil
    user.save!
  end
end
