class MigrationsController < ApplicationController
  before_action :find_migration, only: [:show, :update]

  def index
    @migrations = current_clinic.migrations
  end

  def new
    @migration = current_user.migrations.build
  end

  def create
  initial_time = Time.now
    @migration = current_user.migrations.build(create_migration_params)
    if @migration.save
      uploaded_csv_file = params[:migration][:csv_file]
      raw_csv_string = uploaded_csv_file.read
      csv_file_wrapper = @migration.build_csv_file
      @migration.guess_import_headers_order(raw_csv_string)
      if csv_file_wrapper.save
        csv_file_wrapper.file.attach uploaded_csv_file
        csv_file_wrapper.set_attributes_from_file
        @migration.set_parsing_time(initial_time)
        redirect_to @migration
      else
        flash.now[:danger] = "CSV could not be created"
        render 'new', status: :unprocessable_entity
      end
    else
      flash.now[:danger] = "Migration did not save"
      render 'new', status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    initial_time = Time.now
    case @migration.status
    when :assigning_headers
      @migration.create_import_data(params[:headers]) if params[:headers]
      @migration.add_import_time(initial_time)
    when :in_progress
      act_on_row(params, :rows_to_import) { |row| row.import }
      @migration.add_import_time(initial_time)
      act_on_row(params, :rows_to_reject){ |row| row.reject }
    end
    redirect_to @migration
  end

  private

  def act_on_row(params, rows_key)
    params[rows_key]&.each do |row_id, act_on|
      next if act_on != "1" # import only those with checked checkbox
      import_row = @migration.import_rows.find(row_id)
      yield import_row
    end
  end

  def find_migration
    @migration = current_clinic.migrations.find(params[:id])
  end

  def create_migration_params
    params.require(:migration).permit(:name)
  end
end
