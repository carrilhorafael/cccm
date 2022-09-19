class FiltersController < ApplicationController
  before_action :verify_authenticated
  before_action :set_filter, only: [:show, :update]

  def show
    render json: @filter
  end

  def create
    action = Filter::Create.call(
      performer: current_user,
      filter_params: filter_params
    )

    if action.success?
      render json: action.filter
    else
      render json: action.errors, status: 422
    end
  end

  def update
    action = Filter::Update.call(
      filter: @filter,
      performer: current_user,
      filter_params: filter_params
    )

    if action.success?
      render json: action.filter
    else
      render json: action.errors, status: 422
    end
  end

  private

  def set_filter
    @filter = current_user.filter
  end

  def filter_params
    params.require(:filter).permit(:sortable, restriction:{})
  end
end
