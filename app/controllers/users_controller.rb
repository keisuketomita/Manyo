class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in?, only: [:show, :edit]
  before_action :authenticate_user, only: [:show, :edit]
  before_action :ensure_correct_user, only: [:show, :edit, :update]
  def new
    if logged_in?
      redirect_to tasks_path, notice: "新しくユーザーを作成するにはログアウトしてください"
    else
      @user = User.new
    end
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "ユーザーを編集しました"
    else
      render :edit
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def ensure_correct_user
    if @user.id != current_user.id
      redirect_to tasks_path, notice: "他人のプロフィールを閲覧・編集することはできません"
    end
  end
end
