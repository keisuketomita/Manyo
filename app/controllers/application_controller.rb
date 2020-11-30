class ApplicationController < ActionController::Base
  before_action :basic_auth
  protect_from_forgery with: :exception
  include SessionsHelper
  def authenticate_user
    if @current_user == nil
      redirect_to new_session_path, notice: "ログインが必要です"
    end
  end
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
