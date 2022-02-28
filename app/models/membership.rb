class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :collection, polymorphic: true
end
