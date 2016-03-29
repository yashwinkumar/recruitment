class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_filter :login_from_token
  before_action :authenticate_user!, :require_on_board
  rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized_error

  private

  def handle_not_authorized_error
    render text: "You are not authorized to access these operation."
  end

  def require_on_board
    if current_user and !current_user.profile.on_board_attributes
      flash[:warning] = 'Please update your profile, before continue.'
      redirect_to edit_profile_path(current_user.profile)
    elsif current_user && !current_user.profile.phone_verified && current_user.candidate?
      flash[:alert] = "Please verify your phone number."
      redirect_to phones_path
    end
  end

  def login_from_token
    return if (token = params[:token]).blank?

    if (user = User.find_by_token(token))
      sign_in(user)
    end

    # strip token regardless of success
    redirect_to request.path, params.except(:token, :action, :controller)
  end
end
