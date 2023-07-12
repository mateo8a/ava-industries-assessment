class CsvFile < ApplicationRecord
  belongs_to :migration
  delegate :clinic, to: :migration, allow_nil: true
  has_one_attached :file

  def set_attributes_from_file
    set_preview_rows
    set_number_of_columns
    set_number_of_rows
  end

  def parsed_csv_file
    @parsed_csv_file ||= CSV.parse(raw_csv_file)
  end

  private

  def set_preview_rows
    return if file.blob&.id.nil? || !self.preview_rows.nil?
    rows_to_preview = parsed_csv_file[0..4]
    preview_raw_csv = ""
    rows_to_preview.each do |p|
      preview_raw_csv += p.to_csv
    end
    self.preview_rows = preview_raw_csv
    self.save!
  end

  def set_number_of_columns
    self.number_of_columns = parsed_csv_file[0].count
    self.save!
  end

  def set_number_of_rows
    self.number_of_rows = parsed_csv_file.count - 1 # minus the header row
    self.save!
  end

  def raw_csv_file
    file.download
  end
end
