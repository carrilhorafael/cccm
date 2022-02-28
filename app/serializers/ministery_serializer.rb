class MinisterySerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_one :church
end
