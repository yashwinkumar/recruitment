class Attachment < ActiveRecord::Base
  belongs_to :submission
  mount_uploader :file, AttachmentFileUploader

  validates :file, presence: true
end
