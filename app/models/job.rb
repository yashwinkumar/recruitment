class Job < ActiveRecord::Base
  belongs_to :template
  has_many :submissions, dependent: :destroy
  has_many :interviews, dependent: :destroy
  has_many :job_skills
  has_many :skills, through: :job_skills
  belongs_to :user

  scope :active, -> {where(status: 'active')}
  scope :hold, -> {where(status: 'hold')}
  scope :closed, -> {where(status: 'closed')}


  validates :template_id, :title, :description, :location, :compensation, :hiring_user_id, :consultant_user_id, presence: true

  state_machine :status, :initial => :active do
    event :active do
      transition any => :active
    end

    event :hold do
      transition :active => :hold
    end

    event :close do
      transition :active => :closed, :hold => :closed
    end
  end

  searchable do
    text :title, :location
    string :skills, :multiple => true do
      skills.map(&:name)
    end
    text :skills do
      skills.map(&:name)
    end
  end

  def consultant
    User.find_by id: consultant_user_id
  end

  def hm
    User.find_by id: hiring_user_id
  end

  def active?
    status == "active"
  end

  def hold?
    status == "hold"
  end

  def closed?
    status == "closed"
  end

  def new_submissions
    @new_submissions ||= submissions.active
  end

  def processing_submissions
    @processing_submissions ||= submissions.process
  end
end
