class ChurchSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :is_head
  has_many :ministeries
  has_many :users

end
