class Submission < ActiveRecord::Base
  has_one :resume
  belongs_to :user
  belongs_to :job
end
