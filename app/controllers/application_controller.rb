class ApplicationController < ActionController::Base
  before_action :user_logged_in
  include SessionsHelper

  def user_logged_in
    unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to root_url, status: :see_other
    end
  end
end
