class ClinicMember < ApplicationRecord
  has_secure_password
  belongs_to :clinic
  has_many :migrations

  def name
    "#{first_name} #{last_name}"
  end
end
