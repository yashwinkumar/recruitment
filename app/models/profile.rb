class Profile < ActiveRecord::Base
  belongs_to :user

  mount_uploader :picture, ProfileUploader

  def full_name
    first_name.to_s + " " + last_name.to_s
  end

  def display_picture
    picture.present? ? picture : 'profile.png'
  end

  def display_thumb_picture
    (picture.present? and picture.thumb.present?) ? picture.thumb : 'profile.png'
  end
end

