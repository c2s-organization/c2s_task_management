class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = @current_user.tasks.order('updated_at DESC')
  end

  def new
    @task = @current_user.tasks.build
  end

  def create
    @task = @current_user.tasks.build(task_params)

    if @task.save
      ScrapingJob.perform_later(@task.id)
      NotifyJob.perform_later("Task created", "Task #{@task.title} was created by user_id #{@task.user.id}.")
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
      NotifyJob.perform_later("Task updated", "Task #{@task.title} was updated by user_id #{@task.user.id}.")
      redirect_to tasks_path, notice: 'Tarefa atualizada com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    NotifyJob.perform_later("Task deleted", "Task #{@task.title} was deleted by user_id #{@task.user.id}.")
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