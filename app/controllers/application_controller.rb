class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :require_on_board
  rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized_error

  private

  def handle_not_authorized_error
    render text: "You are not authorized to access these operation."
  end

  def require_on_board
    if current_user and !current_user.profile.on_board?
      flash[:danger] = 'Please update your profile, before continue.'
      redirect_to edit_profile_path(current_user.profile)
    end
  end
end
