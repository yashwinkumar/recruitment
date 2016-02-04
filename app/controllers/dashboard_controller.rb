class DashboardController < ApplicationController
  layout 'dashboard'
  def index
    if current_user.hm? || current_user.consultant?
      redirect_to jobs_path
    else
      redirect_to openings_jobs_path
    end
  end
end
