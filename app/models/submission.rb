class Submission < ActiveRecord::Base
  has_one :resume
  belongs_to :user
  belongs_to :job

  validates_presence_of :user_id, :job_id
  validates_uniqueness_of :user_id, scope: :job_id, message: 'Already submitted for this position.'
end
