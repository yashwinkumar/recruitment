class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :build_profile
  has_one :profile
  private

  def build_profile
    p = Profile.new
    p.user = self
    p.first_name = email.split('@').first
    p.save
  end
end
