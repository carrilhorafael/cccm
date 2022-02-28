class UsersController < ApplicationController
  before_action :verify_authenticated
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :set_church, only: :create

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    action = User::Create.call(
      performer: current_user,
      user_params: user_params
      church: @church
    )

    if action.success?
      render json: action.user, status: :created
    else
      render json: action.error, status: :unprocessable_entity
    end
  end

  def grant_access
    action = User::GrantAccess.call(
      user: user,
      performer: current_user
    )

    if action.success?
      render json: action.user
    else
      render json: action.error, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :birthdate, :marital_status, :location, :member_since, :is_baptized)
    end
end
