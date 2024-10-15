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
      NotificationService.send_notification(@task)

      send_web_scraping_request(@task)
      redirect_to tasks_path, notice: 'Tarefa criada com sucesso.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      NotificationService.send_notification(@task)
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

  def send_web_scraping_request(task)
    uri = URI.parse("http://localhost:3003/scrapings")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
    request.body = { task_id: task.id, url: task.url }.to_json
    http.request(request)
  end
end