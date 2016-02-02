class ResumesController < ApplicationController
  before_action :set_resume, :find_job, :find_submission
  layout 'dashboard'

  def show
    @resume_sections = @resume.resume_sections
  end

  private

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
