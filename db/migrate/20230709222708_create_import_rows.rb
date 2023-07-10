class CreateImportRows < ActiveRecord::Migration[7.0]
  def change
    create_table :import_rows do |t|
      t.references  :migration, null: false, foreign_key: true

      t.timestamps
    end
  end
end
