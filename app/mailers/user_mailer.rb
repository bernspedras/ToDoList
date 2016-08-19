class UserMailer < ApplicationMailer
 default from: 'notifications@ToDoList.com'
 
  def task_complete_email(user, task,colour,phrase)
    @task = task
	@phrase = phrase
	@colour = colour
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
