class User < ApplicationRecord

  has_secure_password

  validates :name, :email, :birthdate, :password_confirmation, :birthdate, :marital_status, :location, :branch, :is_baptized, presence: true
  validates :email, format: {with: /\b[0-9._%a-z\-]+@[a-z]{2, 3}\z/, message: "O email deve ser do domínio IN Junior"}, uniqueness: { case_sensitive: true }
  validate :birthdate_must_be_past

  enum marital_status:{
    "Solteiro(a)": 0,
    "Casado(a)": 1,
    "Viúvo(a)": 2,
    "Divorciado(a)": 3,
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
end
