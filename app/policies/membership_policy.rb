class MembershipPolicy < ApplicationPolicy
  def initialize(user, record)
    # Never allow not logged in access
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user

    super(user, record)
  end

  def create?
    # anyone can "create a membership"
    # it just a join request
    true
  end

  def destroy?
    @user.site_admin? || circle_admin
  end

  def accept?
    @user.site_admin? || circle_admin
  end

  def promote?
    @user.site_admin? || circle_admin
  end

  def demote?
    @user.site_admin? || circle_admin
  end

  private

  def circle_admin
    Membership.exists?(user: @user, circle: @record.circle, admin: true)
  end

end
