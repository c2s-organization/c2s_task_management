class ApplicationController < ActionController::Base
  before_action :authenticate_user

  private

  def authenticate_user
    token = session[:jwt_token]
    return redirect_to login_path, alert: 'Você precisa estar logado para acessar essa página.' unless token

    begin
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)
      @current_user = User.find(decoded_token[0]['user_id'])
    rescue JWT::DecodeError
      session[:jwt_token] = nil
      redirect_to login_path, alert: 'Token inválido, faça login novamente.'
    end
  end
end
