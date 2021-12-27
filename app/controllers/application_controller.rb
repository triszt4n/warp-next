class ApplicationController < ActionController::Base
  def logged_in?
    session[:user_id]
  end
  helper_method :logged_in?

  def has_circle?
    !current_user&.circles.empty?
  end
  helper_method :has_circle?

  def is_in_circle?(circle)
    current_user&.circles.any? { |c| c.id == circle.id }
  end
  helper_method :is_in_circle?

  def logged_in_as_site_admin?
    current_user&.site_admin?
  end
  helper_method :logged_in_as_site_admin?

  def logged_in_as_admin_of?(circle)
    current_user&.memberships.any? { |m| m.circle.id == circle.id && m.admin? }
  end
  helper_method :logged_in_as_admin_of?

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end
  helper_method :current_user

  protected

  def login_required
    redirect_to root_path, notice: 'Be kell jelentkezned!' unless logged_in?
  end

  def membership_required
    redirect_to root_path, notice: 'Előbb jelentkezz egy körbe!' unless has_circle?
  end

  def site_admin_required
    redirect_to root_path, notice: 'Nincs jogosultságod az oldalhoz!' unless logged_in_as_site_admin?
  end
end
