class ImportRowsController < ApplicationController
  before_action :find_import_row, only: [:edit, :update, :show]

  def edit
  end

  def update
    @import_row.reset_warnings
    @import_row.save!
    params[:row_data].each do |attr, value|
      cell = @import_row.get_cell_for_patient_attr(attr)
      value = value.empty? ? nil : value 
      cell.raw_data = value
      cell.save!
    end
    redirect_to @import_row.migration
  end

  def show
    if @import_row.patient.nil?
      redirect_to @import_row.migration
    end
  end

  def find_import_row
    @import_row = current_clinic.import_rows.find(params[:id])
  end
end
