class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  # Lista todas as tarefas
  def index
    @tasks = Task.all
  end

  # Exibe o formulário para criar uma nova tarefa
  def new
    @task = Task.new
  end

  # Cria uma nova tarefa
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: 'Tarefa criada com sucesso.'
    else
      render :new
    end
  end

  # Exibe o formulário para editar uma tarefa existente
  def edit
  end

  # Atualiza uma tarefa existente
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Tarefa atualizada com sucesso.'
    else
      render :edit
    end
  end

  # Exclui uma tarefa
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Tarefa excluída com sucesso.'
  end

  private

  # Define a tarefa com base no ID
  def set_task
    @task = Task.find(params[:id])
  end

  # Permite apenas os parâmetros permitidos para criar/atualizar tarefas
  def task_params
    params.require(:task).permit(:title, :status, :url)
  end
end