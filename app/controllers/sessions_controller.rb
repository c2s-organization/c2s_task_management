class SessionsController < ApplicationController
  include HTTParty
  # TODO: Mover para HabbitMQ?
  skip_before_action :authenticate_user, only: [:new, :login, :new_register, :register]

  def login
    response = AuthenticationService.login(params[:email], params[:password])

    if response.success?
      session[:jwt_token] = response['token']
      redirect_to tasks_path, notice: 'Login realizado com sucesso.'
    else
      flash.now[:alert] = 'Credenciais inválidas'
      render :new
    end
  end

  def register
    response = AuthenticationService.register(params[:email], params[:password], params[:password_confirmation])

    if response.success?
      redirect_to login_path, notice: 'Registro realizado com sucesso. Por favor, faça o login.'
    else
      flash.now[:alert] = 'Erro no registro'
      render :new
    end
  end

  def destroy
    session[:jwt_token] = nil
    redirect_to login_path, notice: 'Logout realizado com sucesso.'
  end
end
