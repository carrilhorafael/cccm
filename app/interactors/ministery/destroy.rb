class Ministery::Destroy < Ministery::Base

  def call
    check_authorization

    ministery.destroy!
  end
end
