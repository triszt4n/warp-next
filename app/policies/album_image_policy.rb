class AlbumImagePolicy < ApplicationPolicy
  def show?
    return true if @record.album.public?

    # if not public, lets check for proper access
    site_admin? || circle_admin? || (circle_member? && @record.album.shared?)
  end

  private

  def site_admin?
    @user.present? && @user.site_admin?
  end

  def circle_admin?
    @user.present? && Membership.exists?(user: @user, circle: @record.album.circle, admin: true)
  end

  def circle_member?
    @user.present? && Membership.exists?(user: @user, circle: @record.album.circle, accepted: true)
  end
end
