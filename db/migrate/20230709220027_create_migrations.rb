class CreateMigrations < ActiveRecord::Migration[7.0]
  def change
    create_table :migrations do |t|
      t.integer     :process_time
      t.text        :description
      t.references  :clinic, null: false, foreign_key: true
      t.references  :clinic_member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
