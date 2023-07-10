class CreateImportHeaders < ActiveRecord::Migration[7.0]
  def change
    create_table :import_headers do |t|
      t.string :patient_attribute, unique: true

      t.timestamps
    end
  end
end
