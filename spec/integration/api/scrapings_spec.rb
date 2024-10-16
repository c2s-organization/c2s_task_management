# FIXME: ActionController::RoutingError: No route matches [PUT] "/api/api/scrapings"
# require 'swagger_helper'
#
# RSpec.describe 'Api::ScrapingsController', type: :request do
#   path '/api/scrapings/{id}' do
#     put 'Update a scraping task' do
#       tags 'Scrapings'
#       consumes 'application/json'
#       parameter name: :id, in: :path, type: :integer, description: 'Task ID'
#       parameter name: :task, in: :body, schema: {
#         type: :object,
#         properties: {
#           status: { type: :string },
#           scraped_data: { type: :string }
#         },
#         required: ['status']
#       }
#
#       response '200', 'Task successfully updated' do
#         let(:id) { Task.create(status: 'in_progress', description: 'Data scraping...', url: 'http://example.com').id }
#         let(:task) { { status: 'completed', scraped_data: 'Final data' } }
#
#         run_test! do |response|
#           expect(response).to have_http_status(:ok)
#           parsed_response = JSON.parse(response.body)
#           expect(parsed_response['task']['status']).to eq('completed')
#           expect(parsed_response['task']['description']).to eq('Final data')
#         end
#       end
#
#       response '422', 'Invalid request' do
#         let(:id) { Task.create(status: 'in_progress', url: 'http://example.com').id }
#         let(:task) { { status: '' } }
#
#         run_test! do |response|
#           expect(response).to have_http_status(:unprocessable_entity)
#           parsed_response = JSON.parse(response.body)
#           expect(parsed_response).to have_key('errors')
#         end
#       end
#     end
#   end
# end
