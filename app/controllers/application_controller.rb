class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

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

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end

  helper_method :current_user

  # Function used in derived classes as before actions
  def not_authorized
    redirect_to root_path, notice: 'Nincs jogosultságod az oldalhoz!'
  end

  def record_not_found
    redirect_to root_url, notice: 'Erőforrás nem találva'
  end
end
