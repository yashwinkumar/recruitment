class ResumesController < ApplicationController
  before_action :set_resume, :find_job, :find_submission
  layout 'dashboard'

  def show
    @resume_sections ||= @resume.resume_sections.order('id asc')
    @comments = submission.comments.where(user_id: current_user.id, label: submission.status)
  end

  def update
    # @resume.update_attributes!(resume_params)
    resume_params[:resume_sections_attributes].each do |k, v|
      resume_section = ResumeSection.find v["id"]
      resume_section.update_attributes(v)
    end
    case params[:next_action]
      when "hire"
        @submission.hire
      when "interview"
        redirect_to new_job_submission_interview_path(@job, @submission)
        return
      when 'process'
        @submission.process
      when "park"
        @submission.park
        @submission.update_attribute(:activity_user_id, current_user.id)
        Notifier.parked_email_to_consultant(@submission).deliver_now if current_user.hm?
        comment = @submission.comments.create({
                                                description: params[:comment],
                                                user_id: current_user.id,
                                                label: params[:next_action]
                                              })
      when "reject"
        @submission.reject
        @submission.update_attribute(:activity_user_id, current_user.id)
        Notifier.discard_email_to_consultant(@submission).deliver_now if current_user.hm?
        comment = @submission.comments.create({
                                                description: params[:comment],
                                                user_id: current_user.id,
                                                label: params[:next_action]
                                              })
      when "undecided"
        @submission.un_decide
      else
    end
    redirect_to job_submissions_path(@job)
  end

  private

  def resume_params
    params.require(:resume).permit({:resume_sections_attributes => [:id, :consultant_rating, :hiring_manager_rating]})
  end

  def set_resume
    @resume = Resume.find(params[:id])
  end

  def find_job
    @job = Job.find(params[:job_id])
  end

  def find_submission
    @submission = Submission.find(params[:submission_id])
  end
end
