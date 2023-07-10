class Clinic < ApplicationRecord
  has_many :patients
  has_many :clinic_members
  has_many :migrations
end
