class Migration < ApplicationRecord
  belongs_to :clinic
  belongs_to :clinic_member
  has_many :import_rows
  has_many :import_cells
  has_many :patients
end
