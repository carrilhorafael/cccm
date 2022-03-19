class User::AddMinisteries < User::Base

  def call
    check_authorization
    ActiveRecord::Base.transaction do
      create_all_memberships
    end
  end

  private

  def check_authorization
    context.fail!(error: "Você não pode editar ministérios de um membro com este nível de permissão") unless context.church.can_edit?(performer)
  end

  def create_all_memberships
    context.ministeries_ids.each do |ministery_id|
      user.memberships.create!(ministery_id: ministery_id)
    end
  end
end
