class MinisterySerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  # has_many :memberships
end
