class AddMigrationAttributesToMigrationModels < ActiveRecord::Migration[7.0]
  def change
    add_column :import_rows, :migration_status, :integer, default: 0
    add_column :import_rows, :conflicts_with_existing_patient, :boolean, default: false
    add_column :import_rows, :invalid_data, :boolean, default: false

    add_index :import_rows, :conflicts_with_existing_patient
    add_index :import_rows, :invalid_data

    add_column :migrations, :notes, :text

    add_reference :patients, :patient_replaced_by, foreign_key: { to_table: :patients }
    add_reference :patients, :migration, foreign_key: true
  end
end
