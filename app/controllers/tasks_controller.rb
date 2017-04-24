class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
        @tasks = Task.all.page(params[:page]).per(10)
    end

    def show
        # @task = Task.find(params[:id])
    end

    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        if @task.save
            flash[:success] = 'taskが正常に投稿されました'
            redirect_to @task
        else
            flash.now[:danger] = 'taskが正常に投稿されまsenndesita'
            render :new
        end
    end
    
    def edit
        # @task = Task.find(params[:id])
    end
    
    def update
        # @task = Task.find(params[:id])
        if @task.update(task_params)
            flash[:success] = 'Task update success'
            redirect_to @task
        else
            flash.now[:danger] = "Task dont update "
            render :edit
        end
    end
    
    def destroy
        # @task = Task.find(params[:id])
        @task.destroy
        flash[:success] = 'task delete success'
        redirect_to tasks_url
    end
  
  
    private
    def set_task
        @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content, :title)
    end
    
end
