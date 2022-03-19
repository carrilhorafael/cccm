class UserSerializer < ActiveModel::Serializer
  attributes :id,
    :title,
    :name,
    :email,
    :is_baptized,
    :age,
    :birthdate,
    :member_since,
    :marital_status,
    :location,
    :gender,
    :phone,
    :last_time_logged_at,
    :has_access,
    :access_garantied_by,
    :access_garantied_at,
    :is_leader,
    :president_pastor,
    :ministeries

  def has_access
    object.has_access?
  end
end
