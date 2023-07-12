class ImportRow < ApplicationRecord
  belongs_to :migration
  belongs_to :patient, optional: true
  has_many :import_cells
  after_save :mark_as_read_only_if_necessary
  scope :pending_valid, -> { where(invalid_data: false, conflicts_with_existing_patient: false, migration_status: 0) }

  def self.pending_non_valid
    self.where(invalid_data: true)
      .or(self.where(conflicts_with_existing_patient: true))
      .where(migration_status: 0)
  end

  enum :migration_status, [:pending, :accepted, :rejected]
  delegate :clinic, to: :migration, allow_nil: false

  INVALID_WARNING_TYPE = "invalid"
  CONFLICT_WARNING_TYPE = "conflict"

  def add_invalid_warning(warning)
    self.invalid_data = true
    add_warning(INVALID_WARNING_TYPE, warning)
  end

  def add_conflict_warning
    self.conflicts_with_existing_patient = true
    add_warning(CONFLICT_WARNING_TYPE, warning)
  end

  def parsed_warnings
    @parsed_warnings = JSON.parse(warnings)
  end

  def mark_as_read_only_if_necessary
    unless pending?
      self.readonly!
      import_cells.each { |c| c.readonly! }
    end
  end

  def import
    create_patient_record
    self.accepted!
  end

  def create_patient_record
    new_patient_attr = {}
    Patient::ASSIGNABLE_ATTRIBUTES.each do |attr|
      new_patient_attr[attr] = data_for(attr)
    end
    patient = clinic.patients.build(new_patient_attr)
    patient.import_row = self
    patient.save!
  end

  def data_for(patient_attribute)
    import_header_id = ImportHeader.where(patient_attribute: patient_attribute).pluck(:id)
    cell = import_cells.find_by(import_header_id: import_header_id)
    cell.raw_data
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
end
