class PatientsController < ApplicationController
  def show
    @patient = current_user.clinic.patients.find(params[:id])
  end
end
