class User::Destroy < User::Base

  def call
    check_authorization
    user.destroy!
  end

  private

  def check_authorization
    context.fail!(error: "Você não apagar usuários do sistema com esse nível de permissão") unless context.church.can_edit?(performer)
  end
end
