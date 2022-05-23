class Church::Destroy < Church::Base

  def call
    check_authorization
    ActiveRecord::Base.transaction do
      update_president_pastor_church if performer.church = church
      update_head_church if church.is_head?
      church.destroy!
    end
  end

  private

  def update_president_pastor_church
    performer.church = Church.where.not(id: church.id).first
    performer.save!
  end

  def update_head_church
    Church.where.not(id: church.id).first.update!(is_head: true)
  end
end
