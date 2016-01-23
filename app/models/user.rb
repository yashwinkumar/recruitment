class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  after_create :build_profile
  has_one :profile

  # Override devise confirm! message
  def confirm!
    welcome_email
    super
  end

  def full_name
    profile.first_name.to_s + " " + profile.last_name.to_s
  end

  private

  def welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def build_profile
    p = Profile.new
    p.user = self
    p.first_name = email.split('@').first
    p.save
  end
end
