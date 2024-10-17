class ScrapingJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    NotifyService.call("Job started", "Scraping task: #{task_id}")
    task = Task.find(task_id)
    task.update(status: 'in_progress')
    ScrapingService.call(task)
    NotifyService.call("Job finished", "Scraping task: #{task_id}")
  end
end
