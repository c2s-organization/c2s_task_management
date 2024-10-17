class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = @current_user.tasks
  end

  def new
    @task = @current_user.tasks.build
  end

  def create
    @task = @current_user.tasks.build(task_params)

    if @task.save
      ScrapingJob.perform_later(@task.id)
      NotificationService.call(@task, @current_user)
      redirect_to tasks_path, notice: 'Tarefa criada com sucesso.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      ScrapingJob.perform_later(@task.id)
      NotificationService.call(@task, @current_user, action: 'update')
      redirect_to tasks_path, notice: 'Tarefa atualizada com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Tarefa excluída com sucesso.'
  end

  private

  def set_task
    @task = @current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :status, :url)
  end
end