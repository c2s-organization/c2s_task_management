class ScrapingJob < ApplicationJob
  queue_as :task_scrape

  retry_on StandardError, wait: 30.seconds, attempts: 5

  def perform(task_id)
    NotifyJob.perform_later("Job started", "Scraping task: #{task_id}")
    task = Task.find(task_id)
    task.update(status: 'in_progress')
    ScrapingService.call(task)
    NotifyJob.perform_later("Job finished", "Scraping task: #{task_id}")
  end
end
