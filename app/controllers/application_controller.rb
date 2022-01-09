class ApplicationController < ActionController::Base
  protected

  def logged_in?
    session[:user_id]
  end
  helper_method :logged_in?

  def in_circle?(circle)
    Membership.exists?(user: current_user, circle: circle)
  end
  helper_method :in_circle?

  def accepted_in_circle?(circle)
    Membership.exists?(user: current_user, circle: circle, accepted: true)
  end
  helper_method :accepted_in_circle?

  def logged_in_as_site_admin?
    current_user&.site_admin?
  end
  helper_method :logged_in_as_site_admin?

  def logged_in_as_admin_of?(circle)
    Membership.exists?(user: current_user, circle: circle, admin: true)
  end
  helper_method :logged_in_as_admin_of?

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end
  helper_method :current_user

  # Function used in derived classes as before actions
  def login_required
    redirect_to root_path, notice: 'Be kell jelentkezned!' unless logged_in?
  end

  # Function used in derived classes as before actions
  def site_admin_required
    redirect_to root_path, notice: 'Nincs jogosultságod az oldalhoz!' unless logged_in_as_site_admin?
  end
end
