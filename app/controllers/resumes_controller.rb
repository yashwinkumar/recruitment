class ResumesController < ApplicationController
  before_action :set_resume, :find_job, :find_submission
  layout 'dashboard'

  def show
    @resume_sections ||= @resume.resume_sections.order('id asc')
    @comments = @submission.comments.where(user_id: current_user.id)
  end

  def update
    # @resume.update_attributes!(resume_params)
    resume_params[:resume_sections_attributes].each do|k,v|
      resume_section = ResumeSection.find v["id"]
      resume_section.update_attributes(v)
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
