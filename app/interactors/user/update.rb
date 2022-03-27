class User::Update < User::Base

  def call
    check_authorization
    assign_attributes
    validate_model
    ActiveRecord::Base.transaction do
      user.save!
      update_memberships
    end
  end

  private

  def check_authorization
    context.fail!(error: "Você não apagar usuários do sistema com esse nível de permissão") unless church.can_edit?(performer)
  end

  def assign_attributes
    user.assign_attributes(context.user_params)
  end

  def validate_model
    context.fail!(error: user.errors.full_messages.join(". ")) unless user.valid?
  end

  def ministeries_ids
    context.ministeries_ids || []
  end

  def update_memberships
    actual_ministeries_ids = user.memberships.pluck(:ministery_id).to_a
    ministeries_to_destroy = actual_ministeries_ids - ministeries_ids
    ministeries_to_create = ministeries_ids - actual_ministeries_ids

    binding.pry
    user.memberships.where(ministery_id: ministeries_to_destroy).destroy_all
    user.memberships.create(ministeries_to_create.map{|m_id| { ministery_id: m_id }})
  end
end
