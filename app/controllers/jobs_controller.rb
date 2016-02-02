class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  layout "dashboard"

  def index
    @jobs = Job.all
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
    @job = Job.new(job_params)
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
      params.require(:job).permit(:title, :description, :location, :template_id)
    end
end
