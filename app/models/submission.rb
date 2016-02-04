class Submission < ActiveRecord::Base
  has_one :resume, dependent: :destroy
  has_one :interview, dependent: :destroy
  belongs_to :user
  belongs_to :job

  validates_presence_of :user_id, :job_id
  validates_uniqueness_of :user_id, scope: :job_id, message: 'Already submitted for this position.'

  state_machine :status, :initial => :submitted do
    event :submit do
      transition any => :submitted
    end
    after_transition :on => :refer, :do => :submission_email

    event :discard do
      transition :submitted => :discarded
    end
    after_transition :on => :discard, :do => :discard_email

    event :shortlist do
      transition :submitted => :shortlisted
    end
    after_transition :on => :shortlisted, :do => :shortlist_email

    event :schedule_interview do
      transition :submitted => :interview_scheduled, :shortlisted => :interview_scheduled
    end
    after_transition :on => :schedule_interview, :do => :interview_email

    event :hire do
      transition :interview_scheduled => :hired, :shortlisted => :hired
    end
    after_transition :on => :hire, :do => :hire_email
  end

  def submission_email
    Notifier.submission_email(self).deliver_now
  end

  def discard_email
    Notifier.discard_email(self).deliver_now
  end

  def shortlist_email
    Notifier.shortlist_email(self).deliver_now
  end

  def interview_email
    Notifier.interview_email(self).deliver_now
  end

  def hire_email
    Notifier.hire_email(self).deliver_now
  end

  def submitted?
    status == 'submitted'
  end

  def shortlisted?
    status == 'shortlisted'
  end

  def interview_scheduled?
    status == 'interview_scheduled' and interview
  end

  def hired?
    status == 'hired'
  end
end
