class Cult::Destroy < Church::Base

  def call
    check_authorization

    cult.destroy!
  end
end
