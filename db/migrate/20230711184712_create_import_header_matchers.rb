class CreateImportHeaderMatchers < ActiveRecord::Migration[7.0]
  def change
    create_table :import_header_matchers do |t|
      t.string      :parsed_csv_header
      t.references  :import_header, foreign_key: true

      t.timestamps
    end
  end
end
