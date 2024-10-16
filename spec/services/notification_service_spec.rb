# spec/services/notification_service_spec.rb
require 'rails_helper'

RSpec.describe NotificationService, type: :service do
  let(:task) { create(:task, title: 'Test Task') }

  describe '.send_notification' do
    it 'sends a notification with task details' do
      response = NotificationService.call(task, 1, action: 'create')
      expect(response.code).to eq(201)

      body = JSON.parse(response.body)
      expect(body['message']).to include('Notificação recebida com sucesso.')
    end
  end
end
