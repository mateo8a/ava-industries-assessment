class Clinic < ApplicationRecord
  has_many :patients
  has_many :doctors
  has_many :nurses
  has_many :staff
  has_many :migrations
  has_many :import_rows, through: :migrations
end
