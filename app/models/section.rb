class Section < ActiveRecord::Base
  belongs_to :template
  has_many :resume_sections
end
