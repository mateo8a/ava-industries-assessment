class CreateClinicMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :clinic_members do |t|
      t.string      :first_name
      t.string      :middle_name
      t.string      :last_name
      t.string      :password_digest, null: false
      t.string      :type, null: false
      t.boolean     :active_member, default: true
      t.boolean     :admin, default: false
      t.references  :clinic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
