class Church::Update < Church::Base

  def call
    check_authorization
    assign_attributes
    validate_model
    ActiveRecord::Base.transaction do
      update_head_church if church.is_head?
      church.save!
    end
  end

  private

  def check_authorization
    context.fail!(error: "Somente o pastor presidente ou um líder da igreja podem executar essa ação") unless church.can_edit?(performer)
  end

  def assign_attributes
    church.assign_attributes(church_params)
  end

  def church_params
    context.church_params
  end

  def update_head_church
    actual_head = Church.find_by(is_head: true)
    return if !actual_head || actual_head == church
    Church.find_by(is_head: true)&.update!(is_head: false)
  end

  def validate_model
    context.fail!(error: church.errors.full_messages.join(". ")) unless church.valid?
  end
end
