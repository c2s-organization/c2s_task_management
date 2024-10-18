require 'rails_helper'
require 'webmock/rspec'

RSpec.describe ScrapingService do
  include ActiveJob::TestHelper

  let(:user) { double("User", id: 2) }
  let(:task) { double("Task", id: 1, user_id: user.id, url: "http://example.com") }
  let(:scraping_url) { "#{ENV['URL_MS_SCRAPING']}/scrapings" }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body_scraping) { { task_id: task.id, user_id: task.user_id, url: task.url }.to_json }
  let(:response) { instance_double(HTTParty::Response) }

  describe '.call' do
    before do
      allow(HTTParty).to receive(:post).with(scraping_url, body: body_scraping, headers: headers).and_return(response)
      allow(response).to receive(:success?).and_return(true)
    end

    it 'makes an HTTP POST request to the scraping URL' do
      ScrapingService.call(task)
      expect(HTTParty).to have_received(:post).with(scraping_url, body: body_scraping, headers: headers)
    end
  end
end
