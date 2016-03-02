class InterviewsController < ApplicationController
  before_action :find_job
  before_action :find_submission
  before_action :set_interview, except: [:new, :create]
  layout 'dashboard'

  def new
    @interview = @submission.build_interview
  end

  def edit
  end

  def create
    @interview = @submission.build_interview(interview_params)
    respond_to do |format|
      ActiveRecord::Base.transaction do
        @interview.save
        @submission.schedule_interview
      end
      if @interview.persisted?
        format.html { redirect_to job_submissions_path, notice: 'Interview was successfully created.' }
        format.json { render :show, status: :created, location: @interview }
      else
        format.html { render :new }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @interview.update(interview_params)
        Notifier.interview_email(@interview.submission).deliver_now
        Notifier.interview_email_to_consultant(@interview.submission).deliver_now
        format.html { redirect_to job_submissions_path, notice: 'Interview was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @interview.destroy
    respond_to do |format|
      format.html { redirect_to '#', notice: 'Interview was successfully destroyed.' }
    end
  end

  private
  def find_job
    @job = Job.find(params[:job_id])
  end

  def find_submission
    @submission = Submission.find(params[:submission_id])
  end

  def set_interview
    @interview = Interview.find(params[:id])
  end

  def interview_params
    params.require(:interview).permit(:user_id, :job_id,:date, :description, :mode)
  end
end
