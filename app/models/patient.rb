class Patient < ApplicationRecord
  default_scope { where(patient_replaced_by_id: nil) }
  belongs_to :clinic
  belongs_to :migration
  has_one :patient_replaced, class_name: "Patient", foreign_key: "patient_replaced_by_id" # See https://guides.rubyonrails.org/association_basics.html#self-joins
  belongs_to :patient_replaced_by, class_name: "Patient", optional: true
end
