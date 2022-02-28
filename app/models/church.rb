class Church < ApplicationRecord
  has_many :users
  has_many :ministeries, dependent: :destroy

  validates :name, :location, presence: true
  validate :church_must_be_unique

  def church_must_be_unique
    if Church.where(name: self.name, location: self.location).length != 0
      self.errors.add(:church, 'Essa igreja já existe')
    end
  end
end
