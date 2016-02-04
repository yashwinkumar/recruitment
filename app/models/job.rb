class Job < ActiveRecord::Base
  belongs_to :template
  has_many :submissions, dependent: :destroy
  has_many :interviews, dependent: :destroy
  belongs_to :user

  def consultant
    User.find_by id: consultant_user_id
  end

  def hm
    User.find_by id: hiring_user_id
  end
end
