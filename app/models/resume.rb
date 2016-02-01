class Resume < ActiveRecord::Base
  belongs_to :submission
  has_many :resume_sections
  belongs_to :template
end
