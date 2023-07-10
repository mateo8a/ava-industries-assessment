class AddEmailToAllUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :clinic_members, :email, :string
    add_index :clinic_members, :email, unique: true

    add_column :ava_admin_users, :email, :string
    add_index :ava_admin_users, :email, unique: true
  end
end
