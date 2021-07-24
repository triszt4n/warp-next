module ApplicationHelper
  def admin_signed_in?
    user_signed_in? and current_user.admin?
  end

  def signed_in_via_omniauth?
    user_signed_in? and current_user.provider == 'authsch'
  end
end
