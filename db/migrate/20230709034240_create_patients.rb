class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.integer   :health_identifier_number, null: :false
      t.string    :health_identifier_province, null: :false
      t.string    :first_name, null: :false
      t.string    :middle_name
      t.string    :last_name, null: :false
      t.integer   :phone
      t.string    :email
      t.string    :address_one
      t.string    :address_two
      t.string    :address_province
      t.string    :address_city
      t.string    :address_postal_code
      t.date      :date_of_birth
      t.string    :sex

      t.timestamps

      t.index [:health_identifier_number, :health_identifier_province], unique: true, 
        name: :index_patients_on_health_identifier_number_and_province
      t.index :phone 
      t.index :email
    end
  end
end