class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def signup_success

  end

end