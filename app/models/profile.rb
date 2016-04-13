class Profile < ActiveRecord::Base
  include UserOnBoard
  belongs_to :user

  mount_uploader :picture, ProfileUploader
  validates_presence_of :first_name, :last_name, :location, :title ,:current_employer

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

