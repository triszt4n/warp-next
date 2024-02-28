class UserPolicy < ApplicationPolicy
  def initialize(user, record)
    # Never allow not logged in access
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user

    super(user, record)
  end

  def adminpage?
    @user.site_admin?
  end

  def show?
    true
  end

  def update?
    adminpage?
  end

  def edit?
    update?
  end

  def destroy?
    # only site admin can delete user, but cannot delete themself
    adminpage? && (@user.uid != @record.uid)
  end
end
