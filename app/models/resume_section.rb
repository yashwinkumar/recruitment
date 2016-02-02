class ResumeSection < ActiveRecord::Base
  belongs_to :resume
  belongs_to :section

  mount_uploader :video, VideoUploader

  validates_presence_of :video, :rating, :resume_id, :section_id
end
