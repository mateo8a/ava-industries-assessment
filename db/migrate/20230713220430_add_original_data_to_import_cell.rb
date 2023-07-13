class AddOriginalDataToImportCell < ActiveRecord::Migration[7.0]
  def change
    add_column :import_cells, :original_data, :string
  end
end
