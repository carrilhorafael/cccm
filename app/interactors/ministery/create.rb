class Ministery::Create < Ministery::Base

  def call
    check_authorization
    build_ministery
    validate_model
    ministery.save!
  end

  private

  def check_authorization
    context.fail!(error: "Você não pode executar essa ação") unless church.can_edit?(performer)
  end

  def build_ministery
    context.ministery = church.ministeries.build(ministery_params)
  end

  def validate_model
    context.fail!(error: ministery.errors.full_messages.join(". ")) unless ministery.valid?
  end

  def ministery_params
    context.ministery_params
  end
end
