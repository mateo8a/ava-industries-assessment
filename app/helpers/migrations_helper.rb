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
end
