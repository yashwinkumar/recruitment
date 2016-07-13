class Submission < ActiveRecord::Base
  has_one :resume, dependent: :destroy
  has_one :interview, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  belongs_to :job
  has_many :attachments, dependent: :destroy
  has_many :available_times, dependent: :destroy

  accepts_nested_attributes_for :attachments, :reject_if => lambda { |a| a[:file].blank? }, allow_destroy: true
  accepts_nested_attributes_for :available_times, :reject_if => lambda { |a| (a[:date].blank? or a[:time].blank) }, allow_destroy: true

  scope :active, -> {where status: 'submitted'}
  scope :un_decided, -> {where status: 'un_decided'}
  scope :process, -> {where status: 'processing'}
  scope :discarded, -> { where status: 'discarded' }
  scope :parked, -> { where status: 'parked' }
  scope :interview, -> {where status: 'interview_scheduled'}
  scope :hired, -> {where status: 'hired'}

  validates_presence_of :user_id, :job_id
  validates_uniqueness_of :user_id, scope: :job_id, message: 'Already submitted for this position.'

  CONSULTANT_STATUSES = {"submitted" => 'New', "processing" => 'Submitted to HM', "un_decided" => 'Undecided', "parked" => 'Parked', "discarded" => 'Rejected', "interview_scheduled" => 'Interview Scheduled', "hired" => 'Hired'}
  HM_STATUSES = {"processing" => 'Submitted to HM', "un_decided" => 'Undecided', "parked" => 'Parked', "discarded" => 'Rejected', "interview_scheduled" => 'Interview Scheduled', "hired" => 'Hired'}

  state_machine :status, :initial => :submitted do
    event :submit do
      transition any => :submitted
    end
    after_transition :on => :submit, :do => :submission_email

    event :discard do
      transition any => :discarded
    end
    after_transition :on => :discard, :do => :discard_email

    event :park do
      transition any => :parked
    end
    after_transition :on => :parking, :do => :parked_email

    event :un_decide do
      transition any => :un_decided
    end
    # after_transition :on => :un_decided, :do => :un_decided_email

    event :process do
      transition any => :processing
    end
    after_transition :on => :processing, :do => :processing_email

    event :schedule_interview do
      transition any => :interview_scheduled
    end
    after_transition :on => :schedule_interview, :do => :interview_email

    event :hire do
      transition any => :hired
    end
    after_transition :on => :hire, :do => :hire_email

    #after_transition :update_activity_user
  end

  def submission_email
    Notifier.submission_email(self).deliver_now
  end

  def discard_email
     Notifier.discard_email(self).deliver_now
  end

  def processing_email
    Notifier.processing_email(self).deliver_now
    Notifier.processing_email_to_hm(self).deliver_now
  end

  def parked_email
     # Notifier.parked_email(self).deliver_now
  end

  def interview_email
    Notifier.meeting_request_with_calendar_to_hm(self.interview).deliver_now
    Notifier.meeting_request_with_calendar_to_candidate(self.interview).deliver_now
  end

  def hire_email
    Notifier.delay.hire_email(self)
    add_hiring_date
  end

  def submitted?
    status == 'submitted'
  end

  def un_decided?
    status == 'un_decided'
  end

  def processing?
    status == 'processing'
  end

  def parked?
    status == 'parked'
  end

  def discarded?
    status == 'discarded'
  end


  def interview_scheduled?
    status == 'interview_scheduled' and interview
  end

  def hired?
    status == 'hired'
  end

  def add_hiring_date
    update_columns(hiring_date: Time.now)
  end
end
