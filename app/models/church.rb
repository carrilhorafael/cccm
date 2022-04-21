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

  def users_grouped_by_birthdate_month
    months = (1..12).to_a
    users_by_birthdate = {}
    months.each do |month|
      users_by_birthdate = users_by_birthdate.merge({ month => self.users.where('extract(month from birthdate) = ?', month).select(:id, :name, :birthdate, :title) })
    end
    users_by_birthdate
  end

  def self.can_view(user)
    if user.president_pastor
      Church.all
    else
      user.church
    end
  end
end
