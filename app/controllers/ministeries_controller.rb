class MinisteriesController < ApplicationController
  before_action :verify_authenticated
  before_action :set_church, only: [:create, :index]
  before_action :set_ministery, only: [:memberships, :create_membership, :show, :update, :destroy]

  # GET /ministeries
  def index
    @ministeries = @church.ministeries

    render json: @ministeries
  end

  def memberships
    @users = @ministery.memberships

    render json: @users
  end

  def create_membership
    action = Ministery::CreateMembership.call(
      ministery: @ministery,
      performer: current_user,
      user_id: membership_params[:user_id],
      is_leader: membership_params[:is_leader],
      notes: membership_params[:notes]
    )

    if action.success?
      render json: action.membership, status: :created
    else
      render json: { message: action.error }, status: :unprocessable_entity
    end
  end

  # GET /ministeries/1
  def show
    render json: @ministery
  end

  # POST /ministeries
  def create
    action = Ministery::Create.call(
      performer: current_user,
      church: @church,
      ministery_params: ministery_params
    )

    if action.success?
      render json: action.ministery, status: :created
    else
      render json: { message: action.error }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ministeries/1
  def update
    if @ministery.update(ministery_params)
      render json: @ministery
    else
      render json: @ministery.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ministeries/1
  def destroy
    @ministery.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ministery
      @ministery = Ministery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ministery_params
      params.require(:ministery).permit(:name, :description)
    end
end
