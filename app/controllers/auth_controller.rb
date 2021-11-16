class AuthController < ApplicationController
  def login
    @user = User.find(email: params[:user][:email])
    @user = @user&.authenticate(params[:user][:password])
    binding.pry
    if @user
      token = JsonWebToken::Base.encode(user_id: @user.id)
      @user.update!(last_time_logged_at: Time.zone.now)
      render json: {token: token, user: UserSerializer.new(@user)}
    else
      render json: {message: "Não foi possível fazer o login"}
    end
  end
end
