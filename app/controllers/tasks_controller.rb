class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :show]
  before_action :logged_in?, only: [:index, :new, :edit, :show]
  before_action :authenticate_user, only: [:index, :new, :edit, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @tasks = current_user.tasks
    case
    when params[:name].present?, params[:status].present?, params[:label_id].present? then
      @tasks = @tasks.label_is(params[:label_id]).name_like(params[:name]).status_is(params[:status])
    when params[:sort_expired_dead_line].present? then
      @tasks = @tasks.dead_line_desc
    when params[:sort_expired_priority].present? then
      @tasks = @tasks.priority_desc
    else
      @tasks = @tasks.created_at_desc
    end
    @tasks = @tasks.page(params[:page])
    @row_count = 1
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
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
    if Read.create(task_id: @task.id, user_id: current_user.id)
      @read = Read.update(read: true)
    end
  end

  private
  def task_params
    params.require(:task).permit(:name, :detail, :dead_line, :status, :priority, { label_ids: [] })
  end
  def set_task
     @task = Task.find(params[:id])
  end
  def ensure_correct_user
    if @task.user_id != current_user.id
      redirect_to tasks_path, notice: "他人のタスクを閲覧・編集・削除することはできません"
    end
  end
end
