class AddForeignKeysToPatients < ActiveRecord::Migration[7.0]
  def change
    add_reference :patients, :clinic, foreign_key: true, null: false
    add_index :patients, [:clinic_id, :health_identifier_number, :health_identifier_province], unique: true,
      name: :index_patients_on_clinic_h_identifier_number_and_province
  end
end
