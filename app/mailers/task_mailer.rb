class TaskMailer < ApplicationMailer
  default from: 'no-reply@example.com'  # Pode personalizar o endereço "from"

  def finished_task(task)
    @task = task
    @user = task.user
    mail(
      to: @user.email,
      subject: "Sua tarefa foi processada com sucesso!"
    )
  end

  def failed_task(task)
    @task = task
    @user = task.user
    mail(
      to: @user.email,
      subject: "Sua tarefa foi processada com erro!"
    )
  end
end
