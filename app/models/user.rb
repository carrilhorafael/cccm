class User < ApplicationRecord
  has_secure_password

  has_many :memberships, dependent: :destroy
  # has_many :ministeries, through: :memberships

  validates :name, :email, :birthdate, :marital_status, :location, presence: true
  validates :password_confirmation, presence: true, :if => :password
  validates :email, uniqueness: { case_sensitive: true }
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
    if Date.today < birthdate
      errors.add(:birthdate, "must be past")
    end
  end

  def set_default_password
    self.password = SecureRandom.alphanumeric(36)
    self.password_confirmation = self.password
  end

  def access_garantied_by
    return unless self.has_access?
    User.find_by(id: self.access_garantied_by_user_id).name || "usuário excluído"
  end

  def has_access?
    self.access_garantied_at != nil
  end

  def church
    membership = self.memberships.find_by(collection_type: "Church")
    membership&.collection.as_json.merge({ is_leader: membership.is_leader, title: membership.title })
  end

  def ministeries
    self.memberships.where(collection_type: "Ministery")&.order('is_leader DESC').map { |membership| membership.collection.as_json.merge({ is_leader: membership.is_leader, title: membership.title }) }
  end
end
