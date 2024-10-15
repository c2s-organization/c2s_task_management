# FIXME: Problema ao mockar o
# require 'rails_helper'
#
# RSpec.describe 'Tasks', type: :request do
#   let(:valid_task_params) { { task: { title: 'Nova Tarefa', status: 'pending', url: 'http://example.com' } } }
#   let(:invalid_task_params) { { task: { title: '', status: 'pending', url: '' } } }
#   let!(:task) { create(:task) }
#
#   before do
#     # Simulando a resposta do microserviço de autenticação
#     allow(HTTParty).to receive(:post).with(any_args).and_return(
#       instance_double(HTTParty::Response, success?: true, body: { token: 'jwt_token' }.to_json)
#     )
#
#     # Simulando o login
#     post login_path, params: { email: 'test@example.com', password: 'password' }
#   end
#
#   describe 'GET /tasks' do
#     it 'retorna a lista de tarefas para o usuário logado' do
#       get tasks_path
#       expect(response).to have_http_status(200)
#       expect(response.body).to include(task.title)
#     end
#   end
#
#   describe 'POST /tasks' do
#     context 'com parâmetros válidos' do
#       it 'cria uma nova tarefa' do
#         expect {
#           post tasks_path, params: valid_task_params
#         }.to change(Task, :count).by(1)
#
#         expect(response).to redirect_to(task_path(Task.last))
#         follow_redirect!
#         expect(response.body).to include('Tarefa criada com sucesso.')
#       end
#     end
#
#     context 'com parâmetros inválidos' do
#       it 'não cria a tarefa e renderiza o formulário novamente' do
#         expect {
#           post tasks_path, params: invalid_task_params
#         }.not_to change(Task, :count)
#
#         expect(response).to render_template(:new)
#         expect(response.body).to include('prohibited this task from being saved')
#       end
#     end
#   end
# end
