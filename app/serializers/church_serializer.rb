class ChurchSerializer < ActiveModel::Serializer
  attributes :id, :name, :location
  has_many :church

end
