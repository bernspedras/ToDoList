class TaskCompleteEmailJob
  include SuckerPunch::Job

  # The perform method is in charge of our code execution when enqueued.
  def perform(user,task,colour,phrase)
    UserMailer.task_complete_email(user,task,colour,phrase).deliver
  end

end