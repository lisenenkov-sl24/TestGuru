class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :current_user, :logged_in?

  private

  def authenticate_user!
    return if current_user

    session[:redirect_after_login] = request.url
    redirect_to login_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
