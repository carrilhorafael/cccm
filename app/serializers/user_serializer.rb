class UserSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :email,
    :is_baptized,
    :age,
    :birthdate,
    :member_since,
    :marital_status,
    :location,
    :phone,
    :last_time_logged_at,
    :has_access,
    :access_garantied_by,
    :access_garantied_at,
    :ministeries,
    :church
end
