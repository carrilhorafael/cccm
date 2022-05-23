class Ministery::Create < Ministery::Base

  def call
    check_authorization
    build_ministery
    validate_model
    ministery.save!
  end

  private

  def build_ministery
    context.ministery = church.ministeries.build(ministery_params)
  end
end
