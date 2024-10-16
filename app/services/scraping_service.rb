class ScrapingService
  require 'httparty'

  NOTIFICATION_URL = 'http://localhost:3003/scrapings'.freeze

  def self.call(task)
    # TODO: Mover para HabbitMQ
    body = { task_id: task.id, url: task.url }

    HTTParty.post(NOTIFICATION_URL, body: body.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end