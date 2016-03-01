class ResumeSectionsController < ApplicationController
  before_action :find_job, :find_submission, :set_resume_section
  layout 'dashboard'

  def update
    if @resume_section.update(resume_section_params)
      flash[:success] = "Successful Updated."
    else
      flash[:success] = "Error Updated."
    end
    redirect_to job_submission_resume_path(@job, @submission, @resume_section.resume)
  end

  private

  def set_resume_section
    @resume_section = @submission.resume.resume_sections.where(id: params[:id]).first
  end

  def find_job
    @job = Job.find(params[:job_id])
  end

  def find_submission
    @submission = @job.submissions.where(params[:submission_id]).first
  end

  def resume_section_params
    params.require(:resume_section).permit(:consultant_rating, :hiring_manager_rating)
  end
end
