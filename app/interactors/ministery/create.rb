class Ministery::Create < Ministery::Base

  def call
    check_authorization
    build_ministery
    validate_model
    ActiveRecord::Base.transaction do
      ministery.save!
      create_ministery_leadership
    end
  end

  private

  def check_authorization
    context.fail!(error: "Você não pode executar essa ação") unless church.can_edit?(performer)
  end

  def build_ministery
    context.ministery = church.ministeries.build(ministery_params)
  end

  def create_ministery_leadership
    context.leaders_ids.each do |leader_id|
      action = Ministery::CreateMembership.call(
        performer: performer,
        ministery: ministery,
        is_leader: true,
        user_id: leader_id,
        notes: ""
      )

      context.fail!(error: action.error) unless action.success?
    end
  end

  def validate_model
    context.fail!(error: ministery.errors.full_messages.join(". ")) unless ministery.valid?
  end

  def ministery_params
    context.ministery_params
  end
end
