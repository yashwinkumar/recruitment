class Skill < ActiveRecord::Base
  has_many :job_skills

  validates :name, :presence => true, :uniqueness => true
end
