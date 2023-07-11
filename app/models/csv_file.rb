class CsvFile < ApplicationRecord
  belongs_to :migration
  delegate :clinic, to: :migration, allow_nil: true
  has_one_attached :file
  before_save :set_preview_rows

  def set_preview_rows
    return if file.blob.nil? || !self.preview_rows.nil?
    self.preview_rows = parsed_csv_file[0..4]
    self.save!
  end

  def parsed_csv_file
    @parsed_csv_file ||= CSV.parse(raw_csv_file)
  end

  def raw_csv_file
    file.download
  end
end
