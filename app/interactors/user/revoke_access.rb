class User::RevokeAccess < User::Base

  def call
    check_authorization
    check_consistency
    revoke_access
  end

  private

  def check_consistency
    context.fail!(errors: error_message(:cannot_revoke_president_pastor_access)) if user.president_pastor && !performer.president_pastor
    context.fail!(errors: error_message(:already_has_not_access)) unless user.has_access?
  end

  def revoke_access
    user.set_default_password
    user.access_garantied_at = nil
    user.access_garantied_by = nil
    user.save!
  end
end
