class CirclePolicy < ApplicationPolicy
  def initialize(user, record)
    # Never allow not logged in access
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user

    super(user, record)
  end

  def index?
    true
  end

  def show?
    # Site admin OR circle member
    @user.site_admin? || Membership.exists?(user: @user, circle: @record, accepted: true)
  end

  def details?
    # Site admin Or circle admin
    @user.site_admin? || Membership.exists?(user: @user, circle: @record, admin: true)
  end

  def create?
    @user.site_admin?
  end

  def new?
    @user.site_admin?
  end

  def update?
    @user.site_admin?
  end

  def edit?
    update?
  end

  def destroy?
    @user.site_admin?
  end

end

