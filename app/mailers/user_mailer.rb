class UserMailer < ApplicationMailer
 default from: 'notifications@ToDoList.com'
 

 def task_complete_email(event)
    @task = event.task
    infoJson = JSON.parse(event.info.to_s)
	@phrase = infoJson["phrase"].to_s
	@colour = infoJson["colour"].to_s
    @user = event.task.user
    mail(to: @user.email, subject: 'Task completed!')
  end
end
