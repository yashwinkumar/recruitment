class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  layout "dashboard"

  def index
    @jobs = current_user.my_jobs
  end

  def show
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
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
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

  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:title, :description, :location, :template_id, :consultant_user_id, :hiring_user_id)
    end
end
