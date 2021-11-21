class User < ApplicationRecord

  has_secure_password

  validates :name, :email, :cpf, :rg, :birthdate, :marital_status, :location, :branch, :is_baptized, presence: true
  validates :password_confirmation, presence: true, :if => :password
  validates :email, uniqueness: { case_sensitive: true }
  validate :birthdate_must_be_past
  # before_create :setter_conditions
  # after_create :send_create_notification

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

  def age
    ((Date.today - self.birthdate)/365.25).to_i
  end

  def birthdate_must_be_past
    if Date.today < birthdate
      errors.add(:birthdate, "Invalid birthdate")
    end
  end

  def setter_conditions
    self.password = "12345678" #SecureRandom.alphanumeric(16)
    self.password_confirmation = self.password
    self.validation_token = "12345678" #SecureRandom.alphanumeric(16)
    self.validation_token_sent_at = Time.zone.now
  end

  def send_create_notification
    #notification by email
  end
end
