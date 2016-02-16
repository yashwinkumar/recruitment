class Notifier < ApplicationMailer
  include SendGrid
  default from: "recruitment@gmail.com"
  layout 'mailer'

  def submission_email(submission)
    @job = submission.job
    @hm = @job.hm
    @consultant = @job.consultant
    @user  = submission.user
    mail(to: [@hm.email, @consultant.email], subject: "#{@user.full_name} Submitted to #{@job.title}")
  end

  def discard_email(submission)
    @submission = submission
    @job = submission.job
    @user  = submission.user
    mail(to: @user.email, subject: "Discarded application for #{@job.title}")
  end

  def discard_email_to_consultant(submission)
    @submission = submission
    @job = submission.job
    @consultant  = @job.consultant
    @candidate  = submission.user
    mail(to: @consultant.email, subject: "Discarded application for #{@job.title}")
  end

  def processing_email(submission)
    @job = submission.job
    @user  = submission.user
    mail(to: @user.email, subject: "You application is processing for #{@job.title}")
  end

  def parked_email(submission)
    @job = submission.job
    @user  = submission.user
    mail(to: @user.email, subject: "You application is parked for #{@job.title}")
  end

  def interview_email(submission)
    @job = submission.job
    @user  = submission.user
    @interview  = submission.interview
    mail(to: @user.email, subject: "Interview Scheduled for #{@job.title}")
  end

  def hire_email(submission)
    @job = submission.job
    @user  = submission.user
    mail(to: @user.email, subject: "Congrats!! you are hired for #{@job.title}")
  end
end
