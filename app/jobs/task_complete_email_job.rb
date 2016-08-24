class TaskCompleteEmailJob
  include SuckerPunch::Job

  def perform(event)
    UserMailer.task_complete_email(event).deliver
  end

end