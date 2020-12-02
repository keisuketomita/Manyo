class TeamsController < ApplicationController
  before_action :set_team, only: [:edit, :update, :destroy, :show]
  before_action :logged_in?, only: [:index, :new, :edit, :show]
  before_action :authenticate_user, only: [:index, :new, :edit, :show]
  before_action :ensure_correct_user, only: [:show]

  def index
    @teams = Team.all
    @teams = @teams.page(params[:page])
    @row_count = 1
  end

  def new
    @team = Team.new
  end
  def create
    @team = Team.new(team_params)
    @team.owner_id = current_user.id
    @user_id = current_user.id
    @team_id = @team.id
    unless @team.users.include?(current_user)
      redirect_to teams_path, notice:"チームメンバーに作成者がいません"
    else
      if @team.save
        redirect_to teams_path, notice:"チームを作成しました"
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    unless team_params[:user_ids].include?("#{@team.owner_id}")
      redirect_to teams_path, notice:"チームメンバーに作成者がいなくなるため、変更は破棄されました"
    else
      if @team.update(team_params)
        redirect_to teams_path, notice: "チームを編集しました"
      else
        render :edit
      end
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_path, notice: "チームを削除しました"
  end

  def show
    @tasks = @team.users.map do |user|
      user.tasks
    end
    @row_count = 1
  end

  private
  def team_params
    params.require(:team).permit(:name, :owner_id, { user_ids: [] })
  end
  def set_team
    @team = Team.find(params[:id])
  end

  def ensure_correct_user
    unless @team.users.include?(current_user)
      redirect_to teams_path, notice: "メンバー以外はチーム詳細を閲覧できません"
    end
  end
end
