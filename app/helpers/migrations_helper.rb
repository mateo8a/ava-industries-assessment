module MigrationsHelper
  def select_tag_generator(migration, column)
    import_headers_order = JSON.parse(migration.import_headers_order)
    option_tags = []
    ImportHeader.all.each do |h|
      option_tags << [h.patient_attribute.to_s.gsub("_", " "), h.id]
    end

    selected_option = import_headers_order[column.to_s]
    options_for_select = options_for_select(option_tags, selected_option)
    select_tag("headers[header_#{column}]".to_sym, options_for_select)
  end

  def formatted_warnings(import_row)
    warnings_hash = import_row.parsed_warnings
    warning_string = ""
    invalid_warnings = warnings_hash[ImportRow::INVALID_WARNING_TYPE]
    conflict_warnings = warnings_hash[ImportRow::CONFLICT_WARNING_TYPE]
    
    if invalid_warnings&.count && invalid_warnings&.count > 0
      warning_string += "There are issues with the following field(s):"
      warnings_hash[ImportRow::INVALID_WARNING_TYPE].each do |field|
        warning_string += " #{field.humanize}"
      end
      warning_string += ". "
    end
    
    if conflict_warnings&.count && conflict_warnings&.count > 0
      warning_string += "This record conflicts with an existing record"
    end

    return warning_string
  end
end
