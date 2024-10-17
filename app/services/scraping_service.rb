class ScrapingService
  require 'httparty'

  NOTIFICATION_URL = "#{ENV["URL_MS_SCRAPING"]}/scrapings".freeze

  def self.call(task)
    body = { task_id: task.id, user_id: task.user_id, url: task.url }
    HTTParty.post(NOTIFICATION_URL, body: body.to_json, headers: { 'Content-Type' => 'application/json' })
    NotifyService.call("Scraping sent", "Scraping task: #{task.id}")
  end
end