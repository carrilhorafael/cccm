class Church::Create < Church::Base

  def call
    check_authorization
    build_church
    validate_model
    ActiveRecord::Base.transaction do
      update_head_church if church.is_head?
      church.save!
    end
  end

  private

  def check_authorization
    context.fail!(error: "Somente o pastor presidente pode executar essa ação") unless performer.president_pastor?
  end

  def build_church
    context.church = Church.new(church_params)
  end

  def church_params
    context.church_params
  end

  def update_head_church
    Church.find_by(is_head: true)&.update!(is_head: false)
  end

  def validate_model
    context.fail!(error: church.errors.full_messages.join(". ")) unless church.valid?
  end
end
