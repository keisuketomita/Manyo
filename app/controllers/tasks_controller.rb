class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :show]

  def index
    if params[:name] && params[:status]
      @tasks = Task.all.name_like(params[:name]).status_is(params[:status])
    elsif params[:name]
      @tasks = Task.all.name_like(params[:name])
    elsif params[:status]
      @tasks = Task.all.status_is(params[:status])
    else
      if params[:sort_expired_dead_line]
        @tasks = Task.all.dead_line_desc
      elsif params[:sort_expired_priority]
        @tasks = Task.all.priority_desc
      else
        @tasks = Task.all.created_at_desc
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice:"タスクを登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  def show
  end

  private
  def task_params
    params.require(:task).permit(:name, :detail, :dead_line, :status, :priority)
  end
  def set_task
     @task = Task.find(params[:id])
  end
end
