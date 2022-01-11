# As of rails 6.1.4 these are the classes that handle ActiveStorage serving,
# so we can set the authorization before_actions there.
active_storage_controllers = [ActiveStorage::Blobs::RedirectController,
                              ActiveStorage::Blobs::ProxyController,
                              ActiveStorage::Representations::BaseController]

active_storage_controllers.each do |controller|
  controller.class_eval do
    before_action :authorize_request

    def authorize_request
      album = Album.find_blob_owner @blob.id
      # If resource is not from an album, or album is public, then no need to authorize.
      return if album.nil? || album.public

      # if album is not public, and user is logged in check permissions
      user = User.find_by(id: session[:user_id])
      unless user.present? && (user.site_admin? || logged_in_as_admin_of?(album.circle) || album.shared?)
        redirect_to '/', notice: 'Az erőforrás eléréséhez be kell jelentkezned'
      end
    end

    # Can't use helpers defined in application_controller because
    # ActiveStorage::BaseController is not a child of it.
    def logged_in_as_admin_of?(circle)
      Membership.exists?(user: current_user, circle: circle, admin: true)
    end
  end
end
