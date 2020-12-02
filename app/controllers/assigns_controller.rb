class AssignsController < ApplicationController
  def create
    @assign = current_user.assigns
    @assign.create(team_id: params[:team_id])
    redirect_to teams_path, notice: "チームに参加しました"
  end
  def destroy
    @assign = current_user.assigns.find_by(id: params[:id])
    @assign.destroy
    redirect_to teams_path, notice: "チームを離脱しました"
  end
end
