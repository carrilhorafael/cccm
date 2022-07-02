class Cult < ApplicationRecord
  belongs_to :church
  has_many :proselytes, dependent: :destroy
  belongs_to :responsible, class_name: "User"

  validate :date_of_must_be_past

  def date_of_must_be_past
    if self.date_of > Date.today
      self.errors.add(:date_of, 'tem que ser no passado')
    end
  end
end
