class ProselytesController < ApplicationController
  before_action :set_church, only: [:create, :index]
  before_action :set_proselyte, only: :destroy

  # GET /proselytes
  def index
    @proselytes = @church.proselytes.order('proselytized_at DESC')

    render json: @proselytes
  end

  # POST /proselytes
  def create
    @proselyte = Proselyte::Create.call(church: @church, proselyte_params: proselyte_params)

    if @proselyte.save
      render json: @proselyte, status: :created, location: @proselyte
    else
      render json: @proselyte.errors, status: :unprocessable_entity
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

    # Only allow a list of trusted parameters through.
    def proselyte_params
      params.require(:proselyte).permit(:name, :proselytized_at, :phone, :church_id)
    end
end
