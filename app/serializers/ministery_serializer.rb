class MinisterySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :users
  has_one :church
end
