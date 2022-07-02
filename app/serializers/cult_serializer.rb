class CultSerializer < ActiveModel::Serializer
  attributes :id, :date_of, :responsible_name, :description
  has_many :proselytes
end
