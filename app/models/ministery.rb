class Ministery < ApplicationRecord
  belongs_to :church
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, :description, presence: true
  validate :ministery_must_be_uniqueness_by_church

  def ministery_must_be_uniqueness_by_church
    if church.ministeries.where(name: self.name).any?
      self.errors.add(:name, :taken)
    end
  end

  def can_edit?(user)
    church.leaders.include?(user) || self.leaders.include?(user)
  end

  def leaders
    self.memberships.where(is_leader: true).map(&:user)
  end
end
