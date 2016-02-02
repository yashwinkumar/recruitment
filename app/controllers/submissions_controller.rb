class SubmissionsController < ApplicationController
  before_action :find_job
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  def index
    @submissions = @job.submissions.all
  end

  def show
  end

  def new
    @submission = current_user.submissions.new
    @template = @job.template
    @template_sections = @template.sections || []
  end

  def edit
  end

  def create
    ActiveRecord::Base.transaction do
      @submission = current_user.submissions.new
      @submission.job_id = @job.id
      if @submission.save
        @resume = @submission.build_resume
        @resume.template = @job.template
        @resume.save
        submission_params[:resume_sections_attributes].each do|k,v|
          @resume_section = @resume.resume_sections.new(v)
          @resume_section.save!
        end
        redirect_to jobs_path, notice: 'Submission was successfully created.'
      else
        @template = @job.template
        @template_sections = @template.sections || []
        render :new
      end
    end
  end

  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def find_job
      @job = Job.find(params[:job_id])
    end

    def set_submission
      @submission = Submission.find(params[:id])
    end

    def submission_params
      params.require(:submission).permit({:resume_sections_attributes => [:video, :rating, :section_id]})
    end
end
