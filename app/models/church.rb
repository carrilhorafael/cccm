class Church < ApplicationRecord
  has_many :ministeries, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :proselytes, dependent: :destroy

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
    months.each { |month| users_by_birthdate = users_by_birthdate.merge({ month => self.users.where('extract(month from birthdate) = ?', month).select(:id, :name, :birthdate, :title).sort{ |a, b| a.birthdate.day <=> b.birthdate.day } }) }
    users_by_birthdate
  end

  def proselytes_in_last_semester
    dates = (0..5).to_a.map { |month_int| Date.today.beginning_of_month - month_int.month }
    proselytes_by_month = {}
    dates.reverse.each do |date|
      key = "#{date.month < 10 ? "0#{date.month}" : date.month}/#{date.year}"
      proselytes_by_month = proselytes_by_month.merge({ key => self.proselytes.where('proselytized_at >= ? AND proselytized_at <= ?', date, date.end_of_month).select(:id, :name, :proselytized_at, :phone).order(:proselytized_at) })
    end
    proselytes_by_month
  end

  def self.can_view(user)
    if user.president_pastor
      Church.all
    else
      user.church
    end
  end
end
