class ApplicationController < ActionController::API

  def verify_authenticated
    render json: {message: "Permissao Negada, faça login primeiro"}, status: 401 and return unless current_user.present?
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
    render json: { message: "Não é mais válido" }, status: 403 and return if !current_user

    action = User::Login.call(user: current_user)
    if action.success?
      render json:  { token: action.token, user: UserSerializer.new(action.user), filter: action.user.filter, church: ChurchSerializer.new(action.user.church)}
    else
      render json: { message: action.error }, status: 403
    end
  end

  def set_church
    @church = Church.find(params[:church_id])
  end
end
