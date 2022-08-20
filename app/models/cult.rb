class Cult < ApplicationRecord
  belongs_to :church
  has_many :proselytes, dependent: :destroy
  belongs_to :responsible, class_name: "User"
end
