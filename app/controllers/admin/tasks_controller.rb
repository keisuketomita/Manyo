class Admin::TasksController < ApplicationController
  before_action :admin_user

  def index
    @tasks = Task.all.created_at_desc.page(params[:page])
    @row_count = 1
  end

  private
  def admin_user
    redirect_to root_path , notice: "あなたには管理者権限がありません" unless current_user.admin?
  end

end
