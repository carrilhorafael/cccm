class Ministery < ApplicationRecord
  belongs_to :church

  validates :name, :description, presence: true
  validates :ministery_must_be_uniqueness_by_church

  def

  def ministery_must_be_uniqueness_by_church
    if church.ministeries.where(name: self.name)
      self.errors.add(:ministery, "esse ministerio já existe para essa igreja")
    end
  end
end
