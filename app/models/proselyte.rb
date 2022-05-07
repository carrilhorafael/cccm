class Proselyte < ApplicationRecord
  belongs_to :church
  belongs_to :cult

  before_validation :set_church, on: :create
  before_validation :set_proselytized_at, on: :create
  validates :name, :phone, presence: true

  private

  def set_church
    self.church = cult.church
  end

  def set_proselytized_at
    self.proselytized_at = cult.date_of
  end
end
