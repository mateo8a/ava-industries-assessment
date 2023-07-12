class ImportRow < ApplicationRecord
  belongs_to :migration
  has_many :import_cells
  enum :migration_status, [:pending, :accepted, :rejected]

  def add_invalid_warning(warning)
    self.invalid_data = true
    add_warning("invalid", warning)
  end

  def add_conflict_warning
    self.conflicts_with_existing_patient = true
    add_warning("conflict", warning)
  end

  private

  def add_warning(type, warning)
    if parsed_warnings[type].nil?
      parsed_warnings[type] = [warning]
    else
      parsed_warnings[type] << warning
    end
    self.warnings = @parsed_warnings.to_json
    self.save!
  end

  def parsed_warnings
    @parsed_warnings = JSON.parse(warnings)
  end
end
