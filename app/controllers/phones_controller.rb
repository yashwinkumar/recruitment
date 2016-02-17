class PhonesController < ApplicationController
  skip_before_action :require_on_board, only: [:show, :verify]

  def show
  end

  def verify
    profile = current_user.profile
    if params[:pin] == profile.phone_verification_code
      flash[:success] = "Phone verification successful."
      profile.update(phone_verified: true)
      redirect_to profile_path(profile)
    else
      flash[:danger] = "Invalid PIN."
      redirect_to phones_path
    end
  end
end

