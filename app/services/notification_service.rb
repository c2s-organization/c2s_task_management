# app/services/notification_service.rb
class NotificationService
  require 'httparty'

  NOTIFICATION_URL = 'http://localhost:3002/notifications'.freeze

  def self.send_notification(task, user)
    body = {
      title: "Task #{task.id} #{task.new_record? ? 'Created' : 'Updated'}",
      body: "Task #{task.title} was #{task.new_record? ? 'created' : 'updated'} by #{user.email}. Details: #{task.description}",
      task_details: {
        task_id: task.id,
        status: task.status,
        extracted_data: task.extracted_data, # Assuming this data exists.
        user_email: user.email,
        user_id: user.id
      }
    }

    HTTParty.post(NOTIFICATION_URL, body: body.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end
