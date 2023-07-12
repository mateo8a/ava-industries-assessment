class AddWarningsToImportRows < ActiveRecord::Migration[7.0]
  def change
    add_column :import_rows, :warnings, :string, default: "{}"
  end
end
