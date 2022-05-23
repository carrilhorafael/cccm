class ApplicationController < ActionController::API

  def verify_authenticated
    render json: [{ error: I18n.t('controllers.base.unauthorized') }], status: 401 and return unless current_user.present?
  end

  def current_user
    header = request.headers["Authorization"]
    header = header.split(" ").last if header

    return nil unless header.present?
    @decoded = JsonWebToken::Base.decode(header)
    return nil unless @decoded
    user = User.find_by(id: @decoded[0]['user_id'])
    return user
  end

  def validate_user
    render json: [{ error: I18n.t('controllers.base.validate_user.token_invalid') }], status: 403 and return if !current_user

    action = User::Login.call(user: current_user)
    if action.success?
      render json:  { token: action.token, user: UserSerializer.new(action.user), filter: action.user.filter, church: ChurchSerializer.new(action.user.church)}
    else
      render json: action.errors, status: 403
    end
  end

  def set_church
    if current_user.president_pastor?
      @church = Church.find(params[:church_id])
    else
      @church = current_user.church
    end
  end
end
