class User::Destroy < User::Base

  def call
    check_authorization
    user.destroy!
  end
end
