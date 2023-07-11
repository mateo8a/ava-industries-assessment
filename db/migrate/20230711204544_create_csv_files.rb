class CreateCsvFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :csv_files do |t|
      t.references  :migration, foreign_key: true
      t.integer     :number_of_columns
      t.string      :preview_rows
      t.integer     :number_of_rows

      t.timestamps
    end
  end
end
