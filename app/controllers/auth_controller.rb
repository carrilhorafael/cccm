class AuthController < ApplicationController
  def login
    action = User::Login.call(email: params[:user][:email], password: params[:user][:password])

    if action.success?
      render json: { token: action.token, user: UserSerializer.new(action.user) }
    else
      render json: { message: action.error }, status: :unprocessable_entity
    end
  end

  def reset

  end
end
