class User < ActiveRecord::Base
  rolify

  attr_accessor :role_id
  has_many :templates, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_many :consultant_jobs, class_name: 'Job', foreign_key: 'consultant_user_id'
  has_many :hm_jobs, class_name: 'Job', foreign_key: 'hiring_user_id'
  has_many :interviews, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  after_create :build_profile
  has_one :profile, :dependent => :destroy

  def my_jobs
    if hm?
      hm_jobs
    elsif consultant?
      consultant_jobs
    end
  end

  # Override devise confirm! message
  def confirm!
    welcome_email
    super
  end

  def full_name
    profile.first_name.to_s + " " + profile.last_name.to_s
  end

  def display_picture
    profile.picture.present? ? profile.picture : 'profile.png'
  end

  def display_thumb_picture
    (profile.picture.present? and profile.picture.thumb.present?) ? profile.picture.thumb : 'profile.png'
  end

  def role
    @role ||= roles.first
  end

  def role_name
    @role_name ||= role ? role.name : nil
  end

  def candidate?
    role_name == "candidate"
  end

  def hm?
    role_name == "hm"
  end

  def consultant?
    role_name == "consultant"
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
