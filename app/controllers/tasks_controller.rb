class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.all
  end
    def edit
    @task = User.find(params[:user_id]).tasks.find(params[:id])
  end
  
  
def create
    #@article = Article.find(params[:article_id])
    @task = current_user.tasks.create(task_params) 
    redirect_to user_tasks_path(current_user)	
  end
  
  def update
	#render plain: params.inspect
	@task = User.find(params[:user_id]).tasks.find(params[:id])
	@task.update_attribute(:completed, params[:completed])
	if params[:task] != nil
	@task.update_attribute(:text, params[:task][:text])	
	end
	redirect_to user_tasks_path(current_user)	
  end
  def destroy
  @task = User.find(params[:user_id]).tasks.find(params[:id])
  @task.destroy
 
  redirect_to user_tasks_path(current_user)	
  end
  private
    def task_params
      params.require(:task).permit(:text, :completed)
    end
end
