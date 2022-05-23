class Ministery::Update < Ministery::Base

  def call
    check_authorization
    assign_attributes
    validate_model
    ministery.save!
  end

  private

  def assign_attributes
    ministery.assign_attributes(ministery_params)
  end
end
