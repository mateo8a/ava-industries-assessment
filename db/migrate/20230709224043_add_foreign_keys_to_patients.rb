class AddForeignKeysToPatients < ActiveRecord::Migration[7.0]
  def change
    add_reference :patients, :clinic, foreign_key: true, null: false
  end
end
