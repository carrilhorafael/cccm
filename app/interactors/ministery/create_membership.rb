class Ministery::CreateMembership < Ministery::Base

  def call
    check_authorization
    build_membership
    validate_model
    membership.save!
  end

  private

  def check_authorization
    context.fail!(error: "Você não pode editar esse ministério") unless ministery.can_edit?(performer)
  end

  def build_membership
    context.membership = ministery.memberships.build(user_id: context.user_id, is_leader: context.is_leader, notes: context.notes)
  end

  def membership
    context.membership
  end

  def validate_model
    context.fail!(error: membership.errors.full_messages.join(". ")) unless membership.valid?
  end
end
