class ChurchInformationsSerializer < ChurchSerializer
  attributes :users_grouped_by_birthdate_month, :proselytes_in_last_semester
  has_many :cults
  has_many :users
  has_many :ministeries
end
