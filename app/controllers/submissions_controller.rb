class SubmissionsController < ApplicationController
  before_action :find_job , except: [:my_submissions]
  before_action :set_submission, except: [:index, :new, :create, :my_submissions]
  layout 'dashboard'

  def index
    @new_submissions = @job.submissions.includes(:user,:job).active
    @processing_submissions = @job.submissions.includes(:user,:job).process
    @parked_submissions = @job.submissions.includes(:user,:job).parked(current_user.id)
    @rejected_submissions = @job.submissions.includes(:user,:job).discarded(current_user.id)
    @interview_submissions = @job.submissions.includes(:user,:job).interview
    @hired_submissions = @job.submissions.includes(:user,:job).hired
    # authorize @submissions
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
    @submission = current_user.submissions.new
    @submission.job_id = @job.id
    @submission.availability_1 = params[:submission][:availability_1]
    @submission.availability_2 = params[:submission][:availability_2]
    @submission.availability_3 = params[:submission][:availability_3]
    ActiveRecord::Base.transaction do
      @submission.save
      @resume = @submission.build_resume
      @resume.template = @job.template
      @resume.save
      submission_params[:resume_sections_attributes].each do|k,v|
        @resume_section = @resume.resume_sections.new(v)
        @resume_section.save!
      end
    end
    if @submission.persisted?
      redirect_to openings_jobs_path, notice: 'Your profile was successfully submitted.'
    else
      @template = @job.template
      @template_sections = @template.sections || []
      render :new
    end
  end

  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'profile was successfully updated.' }
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
      format.html { redirect_to job_submissions_path(@job), notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_status
    if params[:status] == 'process'
      @submission.process
    elsif params[:status] == 'hire'
      @submission.hire
    end
    redirect_to job_submissions_path(@job)
  end

  def save_comment
    comment = @submission.comments.new
    comment.description = params[:comment]
    comment.user_id = current_user.id
    if comment.save
      if params[:status] == 'park'
        @submission.park
        @submission.update_attribute(:activity_user_id, current_user.id)
      elsif params[:status] == 'discard'
        @submission.discard
        @submission.update_attribute(:activity_user_id, current_user.id)
        Notifier.discard_email_to_consultant(@submission).deliver_now if current_user.hm?
      end
      redirect_to job_submissions_path(@job)
    else
      flash[:danger] = 'Something went wrong.'
      redirect_to :back
    end
  end

  def my_submissions
     @submissions = current_user.submissions.includes(:job, :resume)
  end

  private
    def find_job
      @job = Job.find(params[:job_id])
    end

    def set_submission
      @submission = Submission.find(params[:id])
    end

    def submission_params
      params.require(:submission).permit(:availability_1, :availability_2, :availability_3, {:resume_sections_attributes => [:video, :rating, :section_id]})
    end
end
