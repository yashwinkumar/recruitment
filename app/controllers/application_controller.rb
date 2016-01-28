class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized_error

  private

  def handle_not_authorized_error
    render text: "You are not authorized to access these operation."
  end
end
