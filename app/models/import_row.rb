class ImportRow < ApplicationRecord
  belongs_to :migration
  has_many :import_cells
end
