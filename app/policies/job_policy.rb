class JobPolicy < ApplicationPolicy

  def new?
    user.consultant?
  end

  def create?
    new?
  end

  def destroy?
    new?
  end

  def update?
    new?
  end

end