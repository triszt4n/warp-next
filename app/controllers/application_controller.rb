class ApplicationController < ActionController::Base
  def logged_in?
    session[:user_id]
  end
  helper_method :logged_in?

  def is_admin?
    current_user&.admin?
  end
  helper_method :is_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end
  helper_method :current_user

  protected
    def login_required
      unless logged_in?
        redirect_to root_path, notice: "Be kell jelentkezned!"
      end
    end

    def admin_required
      unless is_admin?
        redirect_to root_path, notice: "Nincs jogosultságod az oldalhoz!"
      end
    end
end
