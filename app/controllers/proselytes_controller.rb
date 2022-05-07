class ProselytesController < ApplicationController
  before_action :set_church, only: :index
  before_action :set_cult, only: :create
  before_action :set_proselyte, only: :destroy

  # GET /proselytes
  def index
    @proselytes = @church.proselytes.order('proselytized_at DESC')

    render json: @proselytes
  end

  # POST /proselytes
  def create
    action = Proselyte::Create.call(cult: @cult, performer: current_user, proselyte_params: proselyte_params)

    if action.success?
      render json: action.proselyte, status: :created
    else
      render json: action.errors, status: :unprocessable_entity
    end
  end

  # DELETE /proselytes/1
  def destroy
    @proselyte.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proselyte
      @proselyte = Proselyte.find(params[:id])
    end

    def set_cult
      @cult = current_user.church.cults.find(params[:cult_id])
    end

    # Only allow a list of trusted parameters through.
    def proselyte_params
      params.require(:proselyte).permit(:name, :proselytized_at, :phone, :church_id)
    end
end
