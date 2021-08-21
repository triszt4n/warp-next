class ApplicationController < ActionController::Base
  def logged_in?
    session[:user_id]
  end
  helper_method :logged_in?

  def logged_in_as_admin?
    current_user&.admin?
  end
  helper_method :logged_in_as_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end
  helper_method :current_user

  protected

  def login_required
    redirect_to root_path, notice: 'Be kell jelentkezned!' unless logged_in?
  end

  def admin_required
    redirect_to root_path, notice: 'Nincs jogosultságod az oldalhoz!' unless logged_in_as_admin?
  end
end
