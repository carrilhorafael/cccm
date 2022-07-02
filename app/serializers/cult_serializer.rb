class CultSerializer < ActiveModel::Serializer
  attributes :id, :name, :date_of, :description
  has_many :proselytes
  belongs_to :responsible
end
