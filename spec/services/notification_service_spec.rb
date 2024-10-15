# spec/services/notification_service_spec.rb
require 'rails_helper'

RSpec.describe NotificationService, type: :service do
  let(:user) { create(:user, email: 'user@example.com') }
  let(:task) { create(:task, title: 'Test Task', description: 'Task description', user: user) }

  describe '.send_notification' do
    it 'sends a notification with task details' do
      response = NotificationService.send_notification(task, user)
      expect(response.code).to eq(200)

      body = JSON.parse(response.body)
      expect(body['title']).to include('Task Created')
      expect(body['body']).to include(task.description)
    end
  end
end
