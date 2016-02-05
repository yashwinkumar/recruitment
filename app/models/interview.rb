class Interview < ActiveRecord::Base
  belongs_to :submission
  belongs_to :job
  belongs_to :user
end
