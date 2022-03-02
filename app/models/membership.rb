class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :ministery

  validate :member_already_included

  def member_already_included
    if self.ministery.users.include?(self.user)
      self.errors.add(:user, "is already on ministery")
    end
  end
end
