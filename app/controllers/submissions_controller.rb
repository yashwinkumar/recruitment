class SubmissionsController < ApplicationController
  before_action :find_job
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  def index
    @submissions = Submission.all
  end

  def show
  end

  def new
    @resume = @job.build_resume
    @submission = @job.submissions.new
  end

  def edit
  end

  def create
    @submission = Submission.new(submission_params)

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
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
      params[:submission]
    end
end
