class ImportCell < ApplicationRecord
  belongs_to :migration
  belongs_to :import_row
  belongs_to :import_header
end
