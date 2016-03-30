class JobSkill < ActiveRecord::Base
  belongs_to :job
  belongs_to :skill

  validates_presence_of :job_id, :skill_id
  validates_uniqueness_of :skill_id, :scope => [:job_id]
end
