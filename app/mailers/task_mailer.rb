class TaskMailer < ApplicationMailer
  default from: 'no-reply@example.com'  # Pode personalizar o endereço "from"

  def finish_task(task)
    @task = task
    @user = task.user
    mail(
      to: @user.email,
      subject: "Sua tarefa foi processada: #{@task.title}"
    )
  end
end
