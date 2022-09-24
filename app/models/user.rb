class User < ApplicationRecord
  POSSIBLE_TITLES = ["Pastor(a)", "Membro(a)", "Diácono(isa)", "Obreiro(a)"]
  has_secure_password

  has_many :memberships, dependent: :destroy
  belongs_to :church
  has_many :ministeries, through: :memberships
  has_many :filters, dependent: :destroy
  has_many :cults, dependent: :destroy

  validates :name, :email, :birthdate, :marital_status, :gender, :location, :phone, presence: true
  validates :password_confirmation, presence: true, :if => :password
  validates :email, uniqueness: { case_sensitive: true }
  validates :phone, uniqueness: true
  validates :title, inclusion: { in: POSSIBLE_TITLES }
  validate :birthdate_must_be_past

  enum marital_status:{
    "Solteiro(a)": 0,
    "Casado(a)": 1,
    "Viúvo(a)": 2,
    "Divorciado(a)": 3,
    "Separado(a)": 4
  }

  enum gender:{
    "Masculino": 0,
    "Feminino": 1
  }

  def age
    ((Date.today - self.birthdate)/365.25).to_i
  end

  def birthdate_must_be_past
    if !birthdate && Date.today < birthdate
      errors.add(:birthdate, :must_be_past)
    end
  end

  def set_default_password
    self.password = SecureRandom.alphanumeric(36)
    self.password_confirmation = self.password
  end

  def has_access?
    self.access_garantied_at != nil
  end

  def filter
    self.filters.find_by(source: 'users')
  end

  def self.filtered_by(filter)
    sortable_by = filter.sortable == 'system_access' ? 'is_leader DESC, access_garantied_at DESC' : filter.sortable

    res = ActiveRecord::Base.connection.execute(filter.to_query)
    user_ids = res.map{|e| e["id"]}

    User.where(id: user_ids).order(sortable_by)
  end
end
