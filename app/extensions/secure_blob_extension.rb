ActiveStorage::BaseController.class_eval do
  before_action :set_album
  before_action :authorize_request

  def authorize_request
    # Edge case, image blob is not in an album, for now it should
    # send the image, as only album images are restricted
    return if @album.nil? || @album.public

    user = current_user

    # if album is not public, require login
    return head :forbidden if user.nil?

    # if album is not public, and user is logged in check permissions
    head :forbidden unless user.site_admin? || logged_in_as_admin_of?(@album.circle) || @album.shared?
  end

  # Can't use helpers defined in application_controller because
  # ActiveStorage::BaseController is not a child of it.
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def set_album
    blob     = ActiveStorage::Blob.find_signed(params[:signed_blob_id] || params[:signed_id])
    album_id = blob&.attachments&.where(record_type: Album.name)&.first&.record_id
    @album   = Album.find album_id
  rescue ActiveRecord::RecordNotFound
    @album = nil
  end

  def logged_in_as_admin_of?(circle)
    Membership.exists?(user: current_user, circle: circle, admin: true)
  end
end
