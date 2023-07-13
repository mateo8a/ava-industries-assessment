class Patient < ApplicationRecord
  default_scope { where(patient_replaced_by_id: nil) }
  belongs_to :clinic
  has_one :import_row
  has_one :migration, through: :import_row
  has_one :patient_replaced, class_name: "Patient", foreign_key: "patient_replaced_by_id" # See https://guides.rubyonrails.org/association_basics.html#self-joins
  belongs_to :patient_replaced_by, class_name: "Patient", optional: true

  validates :health_identifier_number, presence: true
  validates :health_identifier_province, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  ASSIGNABLE_ATTRIBUTES = [
    :health_identifier_number,
    :health_identifier_province,
    :first_name,
    :middle_name,
    :last_name,
    :phone,
    :email,
    :address_one,
    :address_two,
    :address_province,
    :address_city,
    :address_postal_code,
    :date_of_birth,
    :sex,
  ]

  def name
    first_name + " " + last_name
  end
end
