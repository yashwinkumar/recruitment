class SubmissionPolicy < ApplicationPolicy

  def index?
    user.hm? || user.consultant?
  end

  def show?
    _job = record.job
    (_job.consultant_user_id == user.id) || (_job.hiring_user_id == user.id)
  end

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    record.job.consultant_user_id == user.id
  end

  def update?
    record.job.consultant_user_id == user.id
  end

end