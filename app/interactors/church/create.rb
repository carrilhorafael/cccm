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

  def build_church
    context.church = Church.new(church_params)
  end

  def update_head_church
    Church.find_by(is_head: true)&.update!(is_head: false)
  end
end
