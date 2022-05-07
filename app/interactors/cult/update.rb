class Cult::Update < Cult::Base

  def call
    check_authorization
    assign_attributes
    validate_model
    cult.save!
  end

  private

  def assign_attributes
    cult.assign_attributes(cult_params)
  end
end
