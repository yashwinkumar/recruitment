class Notifier < ApplicationMailer
  include SendGrid
  default from: "recruitment@gmail.com"
  layout 'mailer'

  def submission_email(submission)
    @job = submission.job
    @consultant = @job.consultant
    @user  = submission.user
    mail(to: @consultant.email, subject: "#{@user.full_name} Submitted to #{@job.title}")
  end

  def discard_email(submission)
    @submission = submission
    @job = submission.job
    @user  = submission.user
    mail(to: @user.email, subject: "Discarded your application for #{@job.title}")
  end

  def discard_email_to_consultant(submission)
    @submission = submission
    @job = submission.job
    @consultant  = @job.consultant
    @candidate  = submission.user
    mail(to: @consultant.email, subject: "Discarded your applicant #{@candidate.full_name} for #{@job.title}")
  end

  def processing_email(submission)
    @job = submission.job
    @user  = submission.user
    mail(to: @user.email, subject: "Your application is processing for #{@job.title}")
  end

  def processing_email_to_hm(submission)
    @submission = submission
    @job = submission.job
    @applicant  = submission.user
    @hm  = @job.hm
    @token = @hm.token ? @hm.token : @hm.new_token!
    mail(to: @hm.email, subject: "You got new application for #{@job.title}")
  end

  def parked_email(submission)
    @job = submission.job
    @user  = submission.user
    mail(to: @user.email, subject: "You application is parked for #{@job.title}")
  end

  def parked_email_to_consultant(submission)
    @submission = submission
    @job = submission.job
    @candidate  = submission.user
    @consultant = @job.consultant
    @comments = submission.comments
    mail(to: @consultant.email, subject: "Your applicant #{@candidate.full_name} is parked for #{@job.title}")
  end

  def interview_email(submission)
    @job = submission.job
    @user  = submission.user
    @interview  = submission.interview
    mail(to: @user.email, subject: "Interview Scheduled for #{@job.title}")
  end

  def interview_email_to_consultant(submission)
    @job = submission.job
    @user  = submission.user
    @consultant  = @job.consultant
    @interview  = submission.interview
    mail(to: @consultant.email, subject: "Hiring Manager Scheduled Interview for your applicant #{@user.full_name} for #{@job.title}")
  end

  def interview_reschedule_email(submission)
    @job = submission.job
    @user  = submission.user
    @interview  = submission.interview
    mail(to: @user.email, subject: "Your Interview Re-Scheduled for #{@job.title}")
  end

  def interview_reschedule_email_to_consultant(submission)
    @job = submission.job
    @user  = submission.user
    @consultant  = @job.consultant
    @interview  = submission.interview
    mail(to: @consultant.email, subject: "Hiring Manager Re-Scheduled Interview for your applicant #{@user.full_name} for #{@job.title}")
  end

  def hire_email(submission)
    @job = submission.job
    @user  = submission.user
    mail(to: @user.email, subject: "Congrats!! you are hired for #{@job.title}")
  end
end
