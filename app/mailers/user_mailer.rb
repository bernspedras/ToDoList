class UserMailer < ApplicationMailer
 default from: 'notifications@ToDoList.com'
 
  def task_complete_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
