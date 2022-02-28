class MinisteriesController < ApplicationController
  before_action :verify_authenticated
  before_action :set_church, only: [:create, :index]
  before_action :set_ministery, only: [:show, :update, :destroy]

  # GET /ministeries
  def index
    @ministeries = Ministery.all

    render json: @ministeries
  end

  # GET /ministeries/1
  def show
    render json: @ministery
  end

  # POST /ministeries
  def create
    @ministery = Ministery::Create.call(
      performer: current_user,
      church: @church,
      ministery_params: ministery_params
    )

    if @ministery.save
      render json: @ministery, status: :created, location: @ministery
    else
      render json: @ministery.errors, status: :unprocessable_entity
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
      params.require(:ministery).permit(:name, :description, :church_id)
    end
end
