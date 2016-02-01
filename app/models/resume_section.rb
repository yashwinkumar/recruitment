class ResumeSection < ActiveRecord::Base
  belongs_to :resume
  belongs_to :sections
end
