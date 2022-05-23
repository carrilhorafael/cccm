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

  def assign_attributes
    church.assign_attributes(church_params)
  end

  def update_head_church
    actual_head = Church.find_by(is_head: true)
    return if !actual_head || actual_head == church
    Church.find_by(is_head: true)&.update!(is_head: false)
  end
end
