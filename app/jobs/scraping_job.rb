class ScrapingJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.find(task_id)
    task.update(status: 'in_progress')
    ScrapingService.call(task)
  end
end
