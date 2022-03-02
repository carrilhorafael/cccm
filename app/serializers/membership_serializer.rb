class MembershipSerializer < ActiveModel::Serializer
  attributes :id, :is_leader, :notes
  belongs_to :user
end
