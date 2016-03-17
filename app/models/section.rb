class Section < ActiveRecord::Base
  belongs_to :template
  has_many :resume_sections

  def to_s
    name.titleize
  end
end
