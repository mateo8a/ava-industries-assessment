class PatientsController < ApplicationController
  before_action :find_patient, only: [:show]
  def index
    @patients = current_clinic
  end
  
  def show
  end

  def find_patient
    @patient = current_clinic.patients.find(params[:id])
  end
end
