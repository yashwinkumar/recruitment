class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]
  layout 'dashboard'
  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      profile_params[:dob] = Date.parse(profile_params[:dob])
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :phone, :dob, :picture)
    end
end
