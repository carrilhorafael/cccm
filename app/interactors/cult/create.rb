class Cult::Create < Cult::Base

  def call
    check_authorization
    build_cult
    validate_model
    cult.save!
  end

  private

  def build_cult
    context.cult = church.cults.build(cult_params)
  end
end
