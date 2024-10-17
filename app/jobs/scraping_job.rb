class ScrapingJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.find(task_id)
    ScrapingService.call(task)
  end
end
