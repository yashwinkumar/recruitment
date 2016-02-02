class Job < ActiveRecord::Base
  belongs_to :template
  has_many :submissions
  belongs_to :user
end
