class Proselyte::Create < Proselyte::Base

  def call
    check_authorization
    build_proselyte
    validate_model
    proselyte.save!
  end

  private

  def check_authorization
    context.fail!(error: "Você não pode executar essa ação") unless church.can_edit?(performer)
  end

  def build_proselyte
    context.proselyte = cult.proselytes.build(proselyte_params)
  end

  def validate_model
    context.fail!(error: proselyte.errors.full_messages.join(". ")) unless proselyte.valid?
  end
end
