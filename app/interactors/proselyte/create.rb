class Proselyte::Create < Proselyte::Base

  def call
    check_authorization
    build_proselyte
    validate_model
    proselyte.save!
  end

  private

  def build_proselyte
    context.proselyte = cult.proselytes.build(proselyte_params)
  end
end
