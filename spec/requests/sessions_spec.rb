# FIXME: Problema ao mockar o
# require 'rails_helper'
#
# RSpec.describe 'Sessions', type: :request do
#   let(:valid_user_params) { { email: 'test@example.com', password: 'password' } }
#   let(:invalid_user_params) { { email: 'test@example.com', password: 'wrongpassword' } }
#
#   describe 'POST /login' do
#     context 'com credenciais válidas' do
#       it 'faz login e retorna um token JWT' do
#         # Simulando a resposta do microserviço de autenticação
#         allow(HTTParty).to receive(:post).with(any_args).and_return(
#           instance_double(HTTParty::Response, success?: true, body: { token: 'jwt_token' }.to_json)
#         )
#
#         post login_path, params: valid_user_params
#         expect(response).to have_http_status(:found) # Redireciona após login bem-sucedido
#         expect(session[:jwt_token]).to eq('jwt_token') # Verifica se o token foi armazenado na sessão
#       end
#     end
#
#     context 'com credenciais inválidas' do
#       it 'não faz login e exibe erro' do
#         # Simulando a resposta do microserviço de autenticação com falha
#         allow(HTTParty).to receive(:post).with(any_args).and_return(
#           instance_double(HTTParty::Response, success?: false)
#         )
#
#         post login_path, params: invalid_user_params
#         expect(response).to render_template(:new)
#         expect(flash[:alert]).to eq('Credenciais inválidas. Por favor, tente novamente.')
#       end
#     end
#   end
# end
