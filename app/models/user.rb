class User < ApplicationRecord

  has_secure_password

  validates :name, :email, :birthdate, :marital_status, :location, :branch, :is_baptized, presence: true
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

  enum branch:{
    "Brasilândia": 0,
    "Barro Vermelho": 1
  }

  enum kind:{
    "member_without_access": -1,
    "member": 0,
    "pastor": 1,
    "pastor_president": 2
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

  def is_admin?
    self.pastor_president? || self.pastor?
  end
end
