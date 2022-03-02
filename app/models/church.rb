class Church < ApplicationRecord
  has_many :ministeries, dependent: :destroy
  has_many :users

  validates :name, :location, presence: true
  validate :church_must_be_unique

  def church_must_be_unique
    if Church.where(name: self.name, location: self.location).length != 0
      self.errors.add(:church, 'Essa igreja já existe')
    end
  end

  def can_edit?(user)
    self.leaders.include?(user)
  end

  def leaders
    self.users.where(is_leader: true)
  end
end
