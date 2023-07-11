class ImportRow < ApplicationRecord
  belongs_to :migration
  has_many :import_cells
  enum :migration_status, [:pending, :accepted, :rejected]
end
