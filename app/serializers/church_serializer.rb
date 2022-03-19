class ChurchSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :is_head
end
