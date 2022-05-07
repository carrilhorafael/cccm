class CultsController < ApplicationController
  before_action :set_church, only: [:create, :index]
  before_action :set_cult, only: [:show, :update, :destroy]

  # GET /cults
  def index
    @cults = Cult.all

    render json: @cults
  end

  # GET /cults/1
  def show
    render json: @cult
  end

  # POST /cults
  def create
    action = Cult::Create.call(church: @church, performer: current_user, cult_params: cult_params)

    if action.success?
      render json: action.cult, status: :created
    else
      render json: { error: action.error }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cults/1
  def update
    action = Cult::Update.call(cult: @cult, performer: current_user, cult_params: cult_params)

    if action.success?
      render json: action.cult
    else
      render json: { error: action.error }, status: :unprocessable_entity
    end
  end

  # DELETE /cults/1
  def destroy
    @cult.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cult
      @cult = Cult.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cult_params
      params.require(:cult).permit(:date_of, :responsible_name, :description)
    end
end
