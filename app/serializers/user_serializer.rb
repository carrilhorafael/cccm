class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :is_baptized, :last_time_logged_at, :age, :birthdate, :member_since, :marital_status, :location
  belongs_to :church
end
