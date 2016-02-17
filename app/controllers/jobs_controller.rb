class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy, :change_status]
  layout "dashboard"

  def index
    @active_jobs = current_user.my_jobs.active
    @hold_jobs = current_user.my_jobs.hold
    @closed_jobs = current_user.my_jobs.closed
    authorize @active_jobs
    authorize @hold_jobs
    authorize @closed_jobs
  end

  def show
    @submission_record = @job.submissions.find_by_user_id current_user.id
  end

  def new
    @job = Job.new
    authorize @job
  end

  def edit
    authorize @job
  end

  def create
    @job = current_user.consultant_jobs.new(job_params)
    authorize @job
    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully posted.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def openings
    @jobs = Job.all
  end

  def update
    respond_to do |format|
      authorize @job
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @job
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_status
    if params[:status] == 'active'
      @job.active
    elsif params[:status] == 'hold'
      @job.hold
    elsif params[:status] == 'close'
      @job.close
    end
    redirect_to :back
  end

  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title, :description, :location, :template_id, :consultant_user_id, :hiring_user_id)
    end
end
