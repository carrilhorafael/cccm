class User::Update < User::Base

  def call
    check_authorization
    assign_attributes
    validate_model
    ActiveRecord::Base.transaction do
      user.save!
      update_memberships
      update_access
    end
  end

  private

  def assign_attributes
    user.assign_attributes(context.user_params.except(:ministeries_ids))
  end

  def update_access
    should_pass = (access_params[:should_have_access] != user.has_access?) || (access_params[:should_have_access] && access_params[:is_leader] != user.is_leader)
    return if access_params.blank? || !should_pass

    if context.access_params[:should_have_access]
      action = User::GrantAccess.call(
        user: user,
        performer: performer,
        is_leader: access_params[:is_leader],
        skip_mailer_notification: user.has_access?
      )
    else
      action = User::RevokeAccess.call(
        user: user,
        performer: performer
      )
    end

    context.fail!(errors: action.errors) unless action.success?
  end

  def ministeries_ids
    context.user_params[:ministeries_ids] if context.user_params.has_key?(:ministeries_ids)
  end

  def access_params
    context.access_params || {}
  end

  def update_memberships
    return unless ministeries_ids
    actual_ministeries_ids = user.memberships.pluck(:ministery_id).to_a
    ministeries_to_destroy = actual_ministeries_ids - ministeries_ids
    ministeries_to_create = ministeries_ids - actual_ministeries_ids

    user.memberships.where(ministery_id: ministeries_to_destroy).destroy_all
    user.memberships.create(ministeries_to_create.map{|m_id| { ministery_id: m_id }})
  end

end
