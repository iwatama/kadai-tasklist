class TasksController < ApplicationController
    ##before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :require_user_logged_in
    before_action :correct_user, only: [:destroy]
    def index
        @tasks = Task.all.page(params[:page]).per(2)
    end

    def show
        # @task = Task.find(params[:id])
    end

    def new
        @task = Task.new
    end
    
    def create
        # @task = Task.new(task_params)
        # if @task.save
        #     flash[:success] = 'taskが正常に登録されました'
        #     redirect_to @task
        # else
        #     flash.now[:danger] = 'taskが登録失敗！！'
        #     render :new
        # end
        
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = 'taskが正常に登録されました'
            redirect_to root_url
        else
            @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
            flash.now[:danger] = 'taskの投稿に失敗しました。'
            render 'toppages/index'
        end
    end
    
    def edit
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = 'Task update success'
            redirect_to @task
        else
            flash.now[:danger] = "Task dont update "
            render :edit
        end
    end
    
    def destroy
        # # @task = Task.find(params[:id])
        # @task.destroy
        # flash[:success] = 'task delete success'
        # redirect_to tasks_url
        
        @task.destroy
        flash[:success] = 'task delete success'
        redirect_back(fallback_location: root_path)
    end
  
  
    private
    def set_task
        @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content, :title, :status)
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
          redirect_to root_path
        end
    end
end
