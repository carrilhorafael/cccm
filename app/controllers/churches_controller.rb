class ChurchesController < ApplicationController
  before_action :verify_authenticated
  before_action :set_church, only: [:resume, :show, :update, :destroy]

  # GET /churches
  def index
    @churches = Church.can_view(current_user)

    render json: @churches
  end

  def resume
    render json: @church.users_grouped_by_birthdate_month
  end

  # POST /churches
  def create
    action = Church::Create.call(
      performer: current_user,
      church_params: church_params
    )

    if action.success?
      render json: action.church, status: :created
    else
      render json: { message: action.error }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /churches/1
  def update
    action = Church::Update.call(church: @church, performer: current_user, church_params: church_params)

    if action.success?
      render json: action.church
    else
      render json: { error: action.error }, status: :unprocessable_entity
    end
  end

  # DELETE /churches/1
  def destroy
    action = Church::Destroy.call(church: @church, performer: current_user)

    unless action.success?
      render json: { error: action.error }, status: 422
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_church
      @church = Church.find_by(id: params[:church_id]) || Church.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def church_params
      params.require(:church).permit(:name, :location, :is_head)
    end
end
