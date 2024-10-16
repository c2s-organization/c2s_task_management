require 'swagger_helper'

RSpec.describe 'Api::ScrapingsController', type: :request do
  path '/api/scrapings/{id}' do
    put 'Update a scraping task' do
      tags 'Scrapings'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'Task ID'
      parameter name: :task, in: :body, schema: {
        '$ref' => '#/components/schemas/TaskUpdate'
      }

      response '200', 'Tarefa atualizada com sucesso' do
        let(:id) { Task.create(status: 'in_progress', description: 'Data scraping...').id }
        let(:task) { { status: 'completed', scraped_data: 'Final data' } }

        run_test!
      end

      response '422', 'Invalid request' do
        let(:id) { Task.create(status: 'in_progress').id }
        let(:task) { { status: '' } }

        run_test!
      end
    end
  end
end
