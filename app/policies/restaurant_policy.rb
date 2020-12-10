class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    record.user == user
  end

  def destroy?
    update?
  end

  def create?
    # !user.nil?
    true
  end
end
