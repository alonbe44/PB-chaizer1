class LocationPolicy < ApplicationPolicy
  def index?
    user.admin? || user.normal?
  end

  def show?
    user.admin? || user.normal?
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
