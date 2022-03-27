class UsersController < ApplicationController
  before_action :verify_authenticated
  before_action :set_user, except: [:create, :index]
  before_action :set_church, only: [:create, :index]

  # GET /users
  def index
    @users = @church.users.filtered_by(current_user.filter)

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
      user_params: user_params,
      church: @church,
      access_params: access_params
    )

    if action.success?
      render json: action.user, status: :created
    else
      render json: {message: action.error}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    action = User::Update.call(
      user: @user,
      performer: current_user,
      user_params: user_params,
      access_params: access_params
    )

    if action.success?
      render json: action.user
    else
      render json: {message: action.error}, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    action = User::Destroy.call(
      user: @user,
      performer: current_user
    )

    if action.success?
      render json: action.user
    else
      render json: {message: action.error}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    def set_user
      @user = User.find_by(id: params[:id]) || User.find_by(id: params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :birthdate, :marital_status, :gender, :location, :phone, :title, :member_since, :is_baptized, :notes, ministeries_ids: [])
    end

    def access_params
      params.require(:user).permit(:should_have_access, :is_leader)
    end
end
