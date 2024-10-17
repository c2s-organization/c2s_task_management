module Api
  class ScrapingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user
    before_action :find_task, only: [:update]

    def update
      if @task.update(status: params[:status], description: params[:scraped_data])
        NotifyService.call("Task updated", "Task #{@task.title} was updated by micro service scraping.")
        TaskMailer.finished_task(@task).deliver_now if @task.completed?
        TaskMailer.failed_task(@task).deliver_now if @task.failed?
        NotifyService.call("Email sent", "Task #{@task.title} email was sent.")
        render json: { task: @task }, status: :ok
      else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def find_task
      @task = Task.find(params[:id])
    end
  end
end
