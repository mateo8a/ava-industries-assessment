require 'csv'

class Migration < ApplicationRecord
  belongs_to :clinic
  belongs_to :clinic_member
  has_many :import_rows
  has_many :import_cells
  has_many :patients, through: :import_rows
  has_one :csv_file

  before_validation :set_clinic_association
  validates :name, presence: true

  def guess_import_headers_order(raw_csv_string)
    import_headers_order = {}
    headers_row = parsed_csv_file(raw_csv_string)[0]
    headers_row.each_with_index do |header, index|
      corresponding_import_header = import_header_matcher_for(header)
      import_headers_order[index] = corresponding_import_header&.import_header_id
    end
    self.import_headers_order = import_headers_order.to_json
    self.save!
  end

  def status
    rows = import_rows.order(:migration_status)
    if !rows.any?
      :assigning_headers
    elsif rows.first.migration_status == "pending"
      :in_progress
    else
      :completed
    end
  end

  def create_import_data(headers)
    assign_headers(headers)
    create_import_rows
  end

  def headers_hash
    JSON.parse(self.import_headers_order)
  end

  private

  def create_import_rows
    csv_file.parsed_csv_file.each_with_index do |csv_row, i|
      next if i == 0
      import_row = import_rows.create!
      import_header_ids = ImportHeader.ids
      csv_row.each_with_index do |csv_cell, j|
        import_header_id = headers_hash[j.to_s].to_i
        next if import_header_id == 0
        import_cell = import_row.import_cells.create!(migration: self, import_header_id: import_header_id, raw_data: csv_cell)
        import_cell.check_if_valid_data
        import_header_ids.delete(import_header_id)
      end
      if import_header_ids.any?
        import_header_ids.each do |import_header_id|
          import_cell = import_row.import_cells.create!(migration: self, import_header_id: import_header_id, raw_data: nil)
          import_cell.check_if_valid_data
        end
      end
    end
  end

  def assign_headers(headers)
    updated_headers = {}
    csv_file.number_of_columns.times do |c|
      updated_headers[c] = headers["header_#{c}"]
    end
    self.import_headers_order = updated_headers.to_json
    self.save!
  end

  def import_header_matcher_for(header)
    search_friendly_header = header.dup
    search_friendly_header.strip!
    search_friendly_header.downcase!
    search_friendly_header.gsub!(" ", "_")
    ImportHeaderMatcher.find_by(parsed_csv_header: search_friendly_header)
  end

  def parsed_csv_file(raw_csv_string)
    raw_csv_string.nil? ? csv_file.parsed_csv_file : CSV.parse(raw_csv_string)
  end

  def set_clinic_association
    if clinic.nil? && !clinic_member.nil?
      self.clinic = clinic_member.clinic
    end
  end
end
