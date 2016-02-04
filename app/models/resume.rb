class Resume < ActiveRecord::Base
  belongs_to :submission
  has_many :resume_sections, dependent: :destroy
  belongs_to :template

  accepts_nested_attributes_for :resume_sections, :reject_if => lambda { |a| a[:video].blank? }, :allow_destroy => true
  validates_presence_of :submission_id, :template_id
end
