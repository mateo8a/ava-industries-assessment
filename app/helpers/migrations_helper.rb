module MigrationsHelper
  def select_tag_generator(migration, column)
    import_headers_order = JSON.parse(migration.import_headers_order)
    option_tags = []
    option_tags << ["Select header...", nil, id: "no-header-option"]
    ImportHeader.all.each do |h|
      option_tags << [h.patient_attribute.to_s.gsub("_", " ").capitalize, h.id]
    end

    selected_option = import_headers_order[column.to_s]
    options_for_select = options_for_select(option_tags, selected_option)
    select_tag("headers[header_#{column}]".to_sym, options_for_select)
  end

  def formatted_warnings(import_row)
    warnings_hash = import_row.parsed_warnings
    warning_string = ""
    warnings_to_concat = []
    invalid_warnings = warnings_hash[ImportRow::INVALID_WARNING_TYPE]
    conflict_warnings = warnings_hash[ImportRow::CONFLICT_WARNING_TYPE]
    
    if invalid_warnings&.count && invalid_warnings&.count > 0
      warnings_hash[ImportRow::INVALID_WARNING_TYPE].each do |field|
        warnings_to_concat << "#{field.humanize}"
      end
      warning_string += "#{warnings_to_concat.join(", ")}. "
    end
    
    if conflict_warnings&.count && conflict_warnings&.count > 0
      warning_string += "Conflicts with existing record"
    end

    return warning_string
  end
end
