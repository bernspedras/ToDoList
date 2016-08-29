class TasksController < ApplicationController

  def index
    @tasks = current_user.tasks.all
  end
    def edit
    @task = User.find(params[:user_id]).tasks.find(params[:id])
  end
  
  
def create
    @task = current_user.tasks.create(task_params)
    respond_to do |format|
        format.html { redirect_to user_tasks_path(current_user)	, notice: 'Task was successfully created.' }
        format.js   {}
        format.json { render json: @task, status: :created, location: @task }    
    end
  #  ActionCable.server.broadcast "AsyncRequestChannel", { title: 'MANDANDO MSG', body: 'All the news that is fit to print' }
   # redirect_to user_tasks_path(current_user)	
  end
 
def complete
	#@user = User.find(params[:user_id])
	@task = Task.find(params[:id])
	if @task.update_attribute(:completed, params[:completed])
        create_task_completed_event
        TaskCompleteEmailJob.perform_async(@event)
		#flash[:success] = "Congratulations on completing a task! A VERY important email was sent to you :)"
	else
		#flash[:failure] = "Error, could not complete task"
	end
   respond_to do |format|
        format.html { redirect_to user_tasks_path(current_user)	, notice: 'Task was successfully completed.' }
        format.js   { }
        format.json { render json: @task, status: :completed, location: @task }    
    end
	#redirect_to user_tasks_path(current_user)	
end
 
  def update
	@task = Task.find(params[:id])
	@task.update_attribute(:completed, params[:completed])
	@task.update_attribute(:text, params[:task][:text])	
	redirect_to user_tasks_path(current_user)	
  end
  
  def destroy
      @task = Task.find(params[:id])
      @task.destroy
    respond_to do |format|
            format.html { redirect_to user_tasks_path(current_user)		, notice: 'Task was successfully deleted.' }
            format.js   {}
            format.json { render json: @task, status: :completed, location: @task }    
    end
  end
  
  private
	
	def create_task_completed_event
		infoValue ||= {}
		infoValue[:colour] = MYCOLOURS[rand(5)]
		infoValue[:phrase] = MYPHRASES[rand(5)]
		@event = Event.create(event_type: 'TaskComplete' , info: infoValue.to_json, task_id: params[:id])
		@event.save
	end
  
    def task_params
      params.require(:task).permit(:text, :completed)
    end
end
