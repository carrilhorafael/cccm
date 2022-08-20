class ChurchesController < ApplicationController
  before_action :verify_authenticated
  before_action :set_church, only: [:resume, :show, :update, :destroy]

  # GET /churches
  def index
    @churches = Church.can_view(current_user)

    render json: @churches
  end

  def show
    render json: @church, serializer: ChurchInformationsSerializer
  end

  def resume
    render json: {
      users_grouped_by_birthdate_month: @church.users_grouped_by_birthdate_month,
      proselytes_in_last_semester: @church.proselytes_in_last_semester
    }
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
      render json: action.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /churches/1
  def update
    action = Church::Update.call(church: @church, performer: current_user, church_params: church_params)

    if action.success?
      render json: action.church
    else
      render json: action.errors, status: :unprocessable_entity
    end
  end

  # DELETE /churches/1
  def destroy
    action = Church::Destroy.call(church: @church, performer: current_user)

    unless action.success?
      render json: action.errors, status: 422
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_church
      @church = Church.can_view(current_user).find_by(id: params[:church_id]) || Church.can_view(current_user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def church_params
      params.require(:church).permit(:name, :location, :is_head)
    end
end
