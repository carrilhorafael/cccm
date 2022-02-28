class Church < ApplicationRecord
  has_many :ministeries, dependent: :destroy
  has_many :memberships, as: :collection, dependent: :destroy

  validates :name, :location, presence: true
  validate :church_must_be_unique

  def church_must_be_unique
    if Church.where(name: self.name, location: self.location).length != 0
      self.errors.add(:church, 'Essa igreja já existe')
    end
  end

  def can_edit(user)
    user.pastor_president?
  end

  def members
    self.memberships&.order('is_leader DESC').map { |membership| membership.user.as_json.merge({is_leader: membership.is_leader, title: membership.title}) }
  end
end
