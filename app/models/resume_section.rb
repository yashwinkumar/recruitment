require 'file_size_validator'
class ResumeSection < ActiveRecord::Base
  belongs_to :resume
  belongs_to :section

  mount_uploader :video, VideoUploader
  validates :video,
            :presence => true,
            :file_size => {
              :maximum => 13.megabytes.to_i
            }
  validates_presence_of :video, :rating, :resume_id, :section_id
end
