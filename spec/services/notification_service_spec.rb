require 'rails_helper'

RSpec.describe NotificationService do
  let(:task) { double('Task', id: 1, title: 'Test Task') }
  let(:current_user) { 123 }
  let(:notification_url) { NotificationService::NOTIFICATION_URL }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:response) { instance_double(HTTParty::Response) }

  describe '.call' do
    before do
      allow(HTTParty).to receive(:post).with(notification_url, body: body_data, headers: headers).and_return(response)
    end

    context 'when action is create' do
      let(:body_data) do
        {
          title: "Task #{task.id} Created",
          body: "Task #{task.title} was created by user_id #{current_user}."
        }.to_json
      end

      it 'sends a notification for task creation' do
        allow(response).to receive(:success?).and_return(true)

        result = NotificationService.call(task, current_user, action: 'create')

        expect(HTTParty).to have_received(:post).with(notification_url, body: body_data, headers: headers)
        expect(result.success?).to be(true)
      end
    end

    context 'when action is update' do
      let(:body_data) do
        {
          title: "Task #{task.id} Updated",
          body: "Task #{task.title} was updated by user_id #{current_user}."
        }.to_json
      end

      it 'sends a notification for task update' do
        allow(response).to receive(:success?).and_return(true)

        result = NotificationService.call(task, current_user, action: 'update')

        expect(HTTParty).to have_received(:post).with(notification_url, body: body_data, headers: headers)
        expect(result.success?).to be(true)
      end
    end

    context 'when the POST request fails' do
      let(:body_data) do
        {
          title: "Task #{task.id} Created",
          body: "Task #{task.title} was created by user_id #{current_user}."
        }.to_json
      end

      it 'returns an unsuccessful response' do
        allow(response).to receive(:success?).and_return(false)

        result = NotificationService.call(task, current_user, action: 'create')

        expect(HTTParty).to have_received(:post).with(notification_url, body: body_data, headers: headers)
        expect(result.success?).to be(false)
      end
    end
  end
end
