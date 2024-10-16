module Api
  class ScrapingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user
    before_action :find_task, only: [:update]

    def update
      if @task.update(status: params[:status], description: params[:scraped_data])
        render json: { message: 'Task successfully updated', task: @task }, status: :ok
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
