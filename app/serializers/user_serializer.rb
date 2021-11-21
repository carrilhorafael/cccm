class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :rg, :cpf, :is_baptized, :last_time_logged_at, :age, :birthdate, :marital_status, :location, :branch, :is_master, :is_manager
end
