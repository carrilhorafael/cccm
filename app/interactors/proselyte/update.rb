class Proselyte::Update < Proselyte::Base

  def call
    check_authorization
    assign_attributes
    validate_model
    proselyte.save!
  end

  private

  def assign_attributes
    proselyte.assign_attributes(proselyte_params)
  end
end
