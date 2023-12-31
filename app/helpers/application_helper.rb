module ApplicationHelper
  def import_header_ids 
    ImportHeader.ids
  end

  def cell_data(import_row, import_header_id, without_original = true)
    if without_original
      import_row.import_cells.where(import_header_id: import_header_id).limit(1).pluck(:raw_data).first
    else
      import_row.import_cells.where(import_header_id: import_header_id).limit(1).pluck(:raw_data, :original_data).first
    end
  end

  def show_time_stat(migration, stat)
    time = migration.statistics_hash[stat]
    if time.nil?
      "0 s"
    else
      "#{'%.2f' % time} s"
    end
  end

  def current_clinic
    current_user&.clinic
  end
end
