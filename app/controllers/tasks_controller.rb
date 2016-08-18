class TasksController < ApplicationController
def create
    #@article = Article.find(params[:article_id])
    @task = current_user.tasks.create(comment_params) 
    redirect_to root_path	
  end
 
  private
    def comment_params
      params.require(:task).permit(:text, false)
    end
end
