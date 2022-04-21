class Proselyte < ApplicationRecord
  belongs_to :church

  validates :name, :phone, :proselytized_at, presence: true
  validate :proselytized_at_must_be_past

  def proselytized_at_must_be_past
    if self.proselytized_at > Date.today
      self.errors.add(:proselytized_at, 'tem que ser no passado')
    end
  end
end
