class TaskMailer < ApplicationMailer
  default from: 'no-reply@example.com'  # Pode personalizar o endereço "from"

  def finish_task(task)
    @task = task
    mail(
      to: "user@example.com",
      subject: "Sua tarefa foi processada: #{@task.title}"
    )
  end
end
