class Notifier < ApplicationMailer
  include SendGrid
  default from: "recruitment@gmail.com"
  layout 'mailer'

  def submission_email(submission)
    @job = submission.job
    @consultant = @job.consultant
    @user = submission.user
    mail(to: @consultant.email, subject: "#{@user.full_name} Submitted to #{@job.title}")
  end

  def discard_email(submission)
    @submission = submission
    @job = submission.job
    @user = submission.user
    mail(to: @user.email, subject: "Discarded your application for #{@job.title}")
  end

  def discard_email_to_consultant(submission)
    @submission = submission
    @job = submission.job
    @consultant = @job.consultant
    @candidate = submission.user
    mail(to: @consultant.email, subject: "Discarded your applicant #{@candidate.full_name} for #{@job.title}")
  end

  def processing_email(submission)
    @job = submission.job
    @user = submission.user
    mail(to: @user.email, subject: "Your application is processing for #{@job.title}")
  end

  def meeting_request_with_calendar_to_hm(interview)
    hm = interview.user
    candidate = interview.submission.user
    availability = interview.available_time
    job = interview.job
    date_time_start= (availability.date.to_s + " " +availability.from.to_s).to_datetime
    date_time_end= (availability.date.to_s + " " +availability.to.to_s).to_datetime
    interview_subject = "#{interview.mode.to_s.titlecase} interview with #{candidate.full_name} on #{availability.date.strftime('%d-%b-%Y')} at #{availability.from} – #{job.title}"
    mail(:to => hm.email ) do |format|
      format.ics {
        cal = Icalendar::Calendar.new
        event = Icalendar::Event.new
        event.dtstart = Icalendar::Values::DateTime.new(date_time_start)
        event.dtend = Icalendar::Values::DateTime.new(date_time_end)
        event.summary = interview_subject
        event.description = interview.description.to_s
        event.ip_class = "PRIVATE"
        event.organizer = Icalendar::Values::CalAddress.new("mailto:#{candidate.email}", cn: "#{candidate.full_name}")
        cal.add_event(event)
        cal.publish
        cal.to_ical
      }
    end
  end

  def meeting_request_with_calendar_to_candidate(interview)
    hm = interview.user
    candidate = interview.submission.user
    availability = interview.available_time
    job = interview.job
    date_time_start= (availability.date.to_s + " " +availability.from.to_s).to_datetime
    date_time_end= (availability.date.to_s + " " +availability.to.to_s).to_datetime
    interview_subject = "#{interview.mode.to_s.titlecase} interview invitation on #{availability.date.strftime('%d-%b-%Y')} at #{availability.from} – #{job.title}"
    mail(:to => candidate.email) do |format|
      format.ics {
        cal = Icalendar::Calendar.new
        event = Icalendar::Event.new
        event.dtstart = Icalendar::Values::DateTime.new(date_time_start)
        event.dtend = Icalendar::Values::DateTime.new(date_time_end)
        event.summary = interview_subject
        event.description = interview.description.to_s
        event.ip_class = "PRIVATE"
        event.organizer = Icalendar::Values::CalAddress.new("mailto:#{hm.email}", cn: "#{hm.full_name}")
        cal.add_event(event)
        cal.publish
        cal.to_ical
      }
    end
  end

  def processing_email_to_hm(submission)
    @submission = submission
    @job = submission.job
    @applicant = submission.user
    @hm = @job.hm
    @token = @hm.token ? @hm.token : @hm.new_token!
    mail(to: @hm.email, subject: "You got new application for #{@job.title}")
  end

  def parked_email(submission)
    @job = submission.job
    @user = submission.user
    mail(to: @user.email, subject: "You application is parked for #{@job.title}")
  end

  def parked_email_to_consultant(submission)
    @submission = submission
    @job = submission.job
    @candidate = submission.user
    @consultant = @job.consultant
    @comments = submission.comments
    mail(to: @consultant.email, subject: "Your applicant #{@candidate.full_name} is parked for #{@job.title}")
  end

  def interview_email(submission)
    @job = submission.job
    @user = submission.user
    @interview = submission.interview
    @available_time = @interview.available_time
    mail(to: @user.email, subject: "Interview Scheduled for #{@job.title}")
  end

  def interview_email_to_consultant(submission)
    @job = submission.job
    @user = submission.user
    @consultant = @job.consultant
    @interview = submission.interview
    @available_time = @interview.available_time
    mail(to: @consultant.email, subject: "Hiring Manager Scheduled Interview for your applicant #{@user.full_name} for #{@job.title}")
  end

  def interview_reschedule_email(submission)
    @job = submission.job
    @user = submission.user
    @interview = submission.interview
    mail(to: @user.email, subject: "Your Interview Re-Scheduled for #{@job.title}")
  end

  def interview_reschedule_email_to_consultant(submission)
    @job = submission.job
    @user = submission.user
    @consultant = @job.consultant
    @interview = submission.interview
    mail(to: @consultant.email, subject: "Hiring Manager Re-Scheduled Interview for your applicant #{@user.full_name} for #{@job.title}")
  end

  def hire_email(submission)
    @job = submission.job
    @user = submission.user
    mail(to: @user.email, subject: "Congrats!! you are hired for #{@job.title}")
  end
end
