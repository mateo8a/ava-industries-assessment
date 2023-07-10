class CreateImportCells < ActiveRecord::Migration[7.0]
  def change
    create_table :import_cells do |t|
      t.references  :import_header, foreign_key: true
      t.references  :import_row, null: false, foreign_key: true
      t.references  :migration, null: false, foreign_key: true
      t.string      :raw_data

      t.timestamps
    end
  end
end
