# app/services/notification_service.rb
class NotificationService
  require 'httparty'

  NOTIFICATION_URL = 'http://localhost:3002/notifications'.freeze

  def self.call(task, current_user, action: 'create')
    # TODO: Mover para HabbitMQ
    body = {
      title: "Task #{task.id} #{action.eql?("create") ? 'Created' : 'Updated'}",
      body: "Task #{task.title} was #{action.eql?("create") ? 'created' : 'updated'} by user_id #{current_user}."
    }

    HTTParty.post(NOTIFICATION_URL, body: body.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end
