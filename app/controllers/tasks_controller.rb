class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      NotificationService.call(@task)

      ScrapingService.call(@task)
      redirect_to tasks_path, notice: 'Tarefa criada com sucesso.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      NotificationService.call(@task)
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
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :status, :url)
  end
end