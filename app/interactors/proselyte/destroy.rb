class Proselyte::Destroy < Proselyte::Base

  def call
    check_authorization

    proselyte.destroy!
  end
end
