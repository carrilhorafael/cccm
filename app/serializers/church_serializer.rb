class ChurchSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :is_head, :users_count, :ministeries_count

  def users_count
    object.users.count
  end

  def ministeries_count
    object.ministeries.count
  end
end
