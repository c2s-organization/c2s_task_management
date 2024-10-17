require 'rails_helper'

RSpec.describe NotifyService do
  let(:task) { double('Task', id: 1, title: 'Test Task') }
  let(:current_user) { 123 }
  let(:notification_url) { NotifyService::NOTIFICATION_URL }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:response) { instance_double(HTTParty::Response) }

  describe '.call' do
    before do
      allow(HTTParty).to receive(:post).with(notification_url, body: body_data, headers: headers).and_return(response)
    end

    context 'when action is create' do
      let(:body_data) do
        {
          title: "title",
          body: "body"
        }.to_json
      end

      it 'sends a notification for task creation' do
        allow(response).to receive(:success?).and_return(true)

        result = NotifyService.call("title", "body")

        expect(HTTParty).to have_received(:post).with(notification_url, body: body_data, headers: headers)
        expect(result.success?).to be(true)
      end
    end

    context 'when action is update' do
      let(:body_data) do
        {
          title: "title",
          body: "body"
        }.to_json
      end

      it 'sends a notification for task update' do
        allow(response).to receive(:success?).and_return(true)

        result = NotifyService.call("title", "body")

        expect(HTTParty).to have_received(:post).with(notification_url, body: body_data, headers: headers)
        expect(result.success?).to be(true)
      end
    end

    context 'when the POST request fails' do
      let(:body_data) do
        {
          title: "title",
          body: "body"
        }.to_json
      end

      it 'returns an unsuccessful response' do
        allow(response).to receive(:success?).and_return(false)

        result = NotifyService.call("title", "body")

        expect(HTTParty).to have_received(:post).with(notification_url, body: body_data, headers: headers)
        expect(result.success?).to be(false)
      end
    end
  end
end
