# app/services/notification_service.rb
class NotificationService
  require 'httparty'

  NOTIFICATION_URL = 'http://localhost:3002/notifications'.freeze

  def self.send_notification(task)
    body = {
      title: "Task #{task.id} #{task.new_record? ? 'Created' : 'Updated'}",
      body: "Task #{task.title} was #{task.new_record? ? 'created' : 'updated'}.",
      task_details: {
        task_id: task.id,
        status: task.status
      }
    }

    HTTParty.post(NOTIFICATION_URL, body: body.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end
