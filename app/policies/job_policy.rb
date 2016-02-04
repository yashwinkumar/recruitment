class JobPolicy < ApplicationPolicy

  def index?
    user.consultant? || user.hm?
  end

  def new?
    user.consultant?
  end

  def create?
    new?
  end

  def destroy?
    create?
  end

  def edit?
    create?
  end

  def update?
    record.hiring_user_id == user.id || record.consultant_user_id == user.id
  end

end