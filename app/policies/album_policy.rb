class AlbumPolicy < ApplicationPolicy

  def initialize(user, record)
    # Never allow not logged in access
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user

    super(user, record)
  end

  # index all albums -> only site admins
  def index?
    @user.site_admin?
  end

  # index owned albums -> everybody
  def myalbums?
    true
  end

  def show?
    # Site admin or accepted in circle or owner
    # Technically there is no way that an owner is not in circle
    @user.site_admin? || accepted_in_circle? || owner?
  end

  # Only those can create an album that are in circles
  def create?
    @user.site_admin? || Membership.exists?(user: @user, accepted: true)
  end

  def new?
    create?
  end

  def update?
    @user.site_admin? || circle_admin? || owner?
  end

  def edit?
    update?
  end

  def destroy?
    @user.site_admin? || circle_admin? || owner?
  end

  def image?
    true
  end

  def add_image?
    # TODO: Clarify sharing scope. Shared in Circle or Shared Globally
    @user.site_admin? || circle_admin? || owner? || (@record.shared? && accepted_in_circle?)
  end

  def delete_image?
    add_image?
  end

  private

  def circle_admin?
    Membership.exists?(user: @user, circle: @record.circle, admin: true)
  end

  def accepted_in_circle?
    Membership.exists?(user: @user, circle: @record.circle, accepted: true)
  end

  def owner?
    @record.user == @user
  end
end
