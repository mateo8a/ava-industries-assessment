class ClinicMember < ApplicationRecord
  has_secure_password
  belongs_to :clinic
end
