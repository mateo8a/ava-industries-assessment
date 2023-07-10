class Admin::AvaUser < ApplicationRecord
  has_secure_password
  self.table_name = "ava_admin_users"
end
