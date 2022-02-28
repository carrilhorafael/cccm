class Ministery < ApplicationRecord
  belongs_to :church
  has_many :memberships, as: :collection, dependent: :destroy

  validates :name, :description, presence: true
  validate :ministery_must_be_uniqueness_by_church

  def ministery_must_be_uniqueness_by_church
    if church.ministeries.where(name: self.name).length != 0
      self.errors.add(:ministery, "esse ministerio já existe para essa igreja")
    end
  end

  def members
    self.memberships&.order('is_leader DESC').map { |membership| membership.user.as_json.merge({is_leader: membership.is_leader, title: membership.title}) }
  end
end
