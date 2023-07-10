class SessionsController < ApplicationController
  before_action :user_logged_in, only: [:new]

  def new
  end

  def create
    user = ClinicMember.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  def user_logged_in
    if logged_in?
      redirect_to current_user
    end
  end
end
