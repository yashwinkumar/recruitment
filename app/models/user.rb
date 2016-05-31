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
  # after_initialize :check_role, if: Proc.new {|u| u.role.nil?}
  has_one :profile, :dependent => :destroy

  def to_s
    "#{profile.first_name} #{profile.last_name}"
  end

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
    (profile.first_name.to_s + " " + profile.last_name.to_s) rescue ''
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

  def user_role_name
    if consultant?
      @name ||= Role.where(name: "consultant").first.label
    elsif hm?
      @name ||= Role.where(name: "hm").first.label
    elsif candidate?
      @name ||= Role.where(name: "candidate").first.label
    end
  end

  def candidate?
    @candidate ||= roles.pluck(:name).include?("candidate")
  end

  def hm?
    @hm ||= roles.pluck(:name).include?("hm")
  end

  def consultant?
    @consultant ||= roles.pluck(:name).include?("consultant")
  end

  def admin?
    @admin ||= roles.pluck(:name).include?("admin")
  end

  def new_token!
    SecureRandom.hex(16).tap do |random_token|
      update_attributes token: random_token
      Rails.logger.info("Set new token for user #{ id }")
    end
  end

  def remove_token!
    update_attributes token: nil
    Rails.logger.info("Remove token for user #{ id }")
  end

  private

  def check_role
    self.add_role :candidate
  end

  def welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def build_profile
    p = Profile.new
    p.user = User.last
    p.first_name = User.last.email.split('@').first
    p.save(validate: false)
  end
end
