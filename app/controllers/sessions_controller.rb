class SessionsController < ApplicationController
  def new
    redirect_to '/auth/oauth'
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  def create
    puts "Callback"
    raw_user = request.env['omniauth.auth']['extra']['raw_info']

    # Authorize only current and only Kir-Dev members
    kirdev_membership = raw_user['eduPersonEntitlement'].find { |e| e.name == "KIR fejlesztők és üzemeltetők" }
    authorized = kirdev_membership.end.nil?

    @user = User.find_or_create_by(uid: raw_user['internal_id']) do |u|
      u.name = raw_user['displayName']
      u.email = raw_user['mail']
      u.authorized = authorized
    end

    if @user.authorized? || @user.force_authorized? || @user.admin? then
      session[:user_id] = @user.id
      redirect_to root_path
    else
      if kirdev_membership.nil? then
        redirect_to root_path, notice: "Nincs jogosultságod: Nem vagy Kir-Dev tag!"
      else
        redirect_to root_path, notice: "Nincs jogosultságod: Lejárt Kir-Dev tagságod!"
      end
    end
  end
end
