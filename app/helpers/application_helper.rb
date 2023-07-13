module ApplicationHelper
  def import_header_ids 
    ImportHeader.ids
  end

  def cell_data(import_row, import_header_id)
    import_row.import_cells.where(import_header_id: import_header_id).limit(1).pluck(:raw_data).first
  end
end
