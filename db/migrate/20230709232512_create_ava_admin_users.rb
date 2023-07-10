class CreateAvaAdminUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :ava_admin_users do |t|
      t.string      :first_name
      t.string      :middle_name
      t.string      :last_name
      t.string      :password_digest, null: false

      t.timestamps
    end
  end
end
