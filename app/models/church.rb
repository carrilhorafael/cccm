class Church < ApplicationRecord
  has_many :ministeries, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :name, :location, presence: true
  validate :church_must_be_unique, on: [:create, :update]

  def church_must_be_unique
    if Church.where(name: self.name, location: self.location).length > 0
      self.errors.add(:church, 'Essa igreja já existe')
    end
  end

  def can_edit?(user)
    user.president_pastor? || (user.is_leader? && self == user.church)
  end

  def self.can_view(user)
    if user.president_pastor
      Church.all
    else
      user.church
    end
  end
end
