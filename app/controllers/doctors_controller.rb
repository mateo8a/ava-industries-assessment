class DoctorsController < ApplicationController
  before_action :correct_user

  def show
  end

  def correct_user
    @user = Doctor.find(params[:id])
    redirect_to(root_url, status: :see_other) unless @user == current_user
  end
end
