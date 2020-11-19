class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :update, :destroy, :change_admin]

  def index
    @users = User.includes(:tasks).created_at_desc.page(params[:page])
    @row_count = 1
  end

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end
  def show
    @tasks = @user.tasks.page(params[:page])
    @row_count = 1
  end
  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: "ユーザーを編集しました"
    else
      render :edit
    end
  end
  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました"
    else
      redirect_to admin_users_path, notice: "管理者は2人以上必要です"
    end
  end
  def change_admin
    if @user.admin
      @user.admin = "false"
      if @user.update(user_params_admin)
        redirect_to admin_users_path, notice: "管理者権限を削除しました"
      else
        redirect_to admin_users_path, notice: "管理者は2人以上必要です"
      end
    else
      @user.admin = "true"
      @user.update(user_params_admin)
      redirect_to admin_users_path, notice: "管理者権限を付与しました"
    end
  end

  private
  def admin_user
    redirect_to root_path , notice: "あなたには管理者権限がありません" unless current_user.admin?
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  def user_params_admin
    params.permit(:admin)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
