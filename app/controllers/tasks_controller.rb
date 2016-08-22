class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.all
  end
    def edit
    @task = User.find(params[:user_id]).tasks.find(params[:id])
  end
  
  
def create
    @task = current_user.tasks.create(task_params) 
    redirect_to user_tasks_path(current_user)	
  end
 
def complete
	@user = User.find(params[:user_id])
	@task = @user.tasks.find(params[:id])
	if @task.update_attribute(:completed, params[:completed])
		@phrase = MYPHRASES[rand(5)]
		@colour = MYCOLOURS[rand(5)]
		TaskCompleteEmailJob.perform_async(@user, @task, @colour, @phrase)
		createNewEvent
		flash[:success] = "Congratulations on completing a task! A VERY important email was sent to you :)"
	else
		flash[:failure] = "Error, could not complete task"
	
	end
	redirect_to user_tasks_path(current_user)	
end
 
  def update
	@task = User.find(params[:user_id]).tasks.find(params[:id])
	@task.update_attribute(:completed, params[:completed])
	@task.update_attribute(:text, params[:task][:text])	
	redirect_to user_tasks_path(current_user)	
  end
  
  def destroy
      @task = User.find(params[:user_id]).tasks.find(params[:id])
      @task.destroy
      redirect_to user_tasks_path(current_user)	
  end
  
  private
	
	def createNewEvent
		infoValue ||= {}
		infoValue[:colour] = @colour
		infoValue[:phrase] = @phrase
		infoValue[:user] = @user.name
		@event = Event.new(event_type: 'TaskComplete' , info: infoValue)
		@event.save
	end
  
    def task_params
      params.require(:task).permit(:text, :completed)
    end
end
