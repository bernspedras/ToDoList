class TaskCompleteEmailJob
  include SuckerPunch::Job

  # The perform method is in charge of our code execution when enqueued.
  def perform(user)
    UserMailer.task_complete_email(user).deliver
  end

end