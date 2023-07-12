class MigrationsController < ApplicationController
  before_action :find_migration, only: [:show, :update]
  def new
    @migration = current_user.migrations.build
  end

  def create
    @migration = current_user.migrations.build(create_migration_params)
    if @migration.save
      uploaded_csv_file = params[:migration][:csv_file]
      raw_csv_string = uploaded_csv_file.read
      csv_file_wrapper = @migration.build_csv_file
      @migration.set_import_headers_order(raw_csv_string)
      if csv_file_wrapper.save
        csv_file_wrapper.file.attach uploaded_csv_file
        csv_file_wrapper.set_attributes_from_file
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
    @migration.create_import_data(params[:headers]) if params[:headers]
    redirect_to @migration
  end

  private 

  def find_migration
    @migration = current_user.migrations.find(params[:id])
  end

  def create_migration_params
    params.require(:migration).permit(:name)
  end
end
