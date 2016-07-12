class Interview < ActiveRecord::Base
  belongs_to :submission
  belongs_to :job
  belongs_to :user
  belongs_to :available_time
  after_create :notify_interview

  after_save :update_interview_again, if: :available_time_id_changed?

  def notify_interview
    begin
      client = Twilio::REST::Client.new("AC876aa6ede2d2a4307e809e126b2e4699", "85b5f9b5a6cc27b7a3c12ae20c456ce3")
      client.messages.create(
        from: "+14242851283",
        to: submission.user.profile.phone,
        body: "#{job.title}. Your interview is scheduled on #{date}."
      )
    rescue Exception => e
      self.errors.add(:user_id, "Phone number is not valid")
    end
  end
  
  def update_interview_again
    Notifier.meeting_request_with_calendar_to_hm(self).deliver_now
    Notifier.meeting_request_with_calendar_to_candidate(self).deliver_now
  end
end
