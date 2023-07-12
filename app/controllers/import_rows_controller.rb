class ImportRowsController < ApplicationController
  before_action :find_import_row, only: [:edit, :update]
  def edit
  end

  def update
    @import_row.reset_warnings
    @import_row.save!
    params[:row_data].each do |attr, value|
      cell = @import_row.get_cell_for_patient_attr(attr)
      cell.raw_data = value
      cell.save!
      # cell.check_if_valid_data
    end
    redirect_to @import_row.migration
  end

  def find_import_row
    @import_row = current_user.clinic.import_rows.find(params[:id])
  end
end
