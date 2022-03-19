class User::RemoveMinistery < User::Base

  def call
    check_authorization
    ActiveRecord::Base.transaction do
      remove_ministeries
    end
  end

  private

  def check_authorization
    context.fail!(error: "Você não pode editar ministérios de um membro com este nível de permissão") unless context.church.can_edit?(performer)
  end

  def create_all_memberships
    memberships.each do |membership|
      membership.destroy!
    end
  end

  def memberships
    user.memberships.where(ministery_id: context.ministeries_ids)
  end
end
