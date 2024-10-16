require 'rails_helper'

RSpec.describe ScrapingService do
  let(:task) { double('Task', id: 1, url: 'http://example.com/scrape') }
  let(:scraping_url) { ScrapingService::NOTIFICATION_URL }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body_data) { { task_id: task.id, url: task.url }.to_json }
  let(:response) { instance_double(HTTParty::Response) }

  describe '.call' do
    before do
      allow(HTTParty).to receive(:post).with(scraping_url, body: body_data, headers: headers).and_return(response)
    end

    context 'when the POST request is successful' do
      it 'returns a successful response' do
        allow(response).to receive(:success?).and_return(true)

        result = ScrapingService.call(task)

        expect(HTTParty).to have_received(:post).with(scraping_url, body: body_data, headers: headers)
        expect(result.success?).to be(true)
      end
    end

    context 'when the POST request fails' do
      it 'returns an unsuccessful response' do
        allow(response).to receive(:success?).and_return(false)

        result = ScrapingService.call(task)

        expect(HTTParty).to have_received(:post).with(scraping_url, body: body_data, headers: headers)
        expect(result.success?).to be(false)
      end
    end
  end
end
