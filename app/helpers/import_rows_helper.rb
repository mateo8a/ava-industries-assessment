module ImportRowsHelper
  def cell_text_tag(patient_attr, raw_data)
    text_field_tag("row_data[#{patient_attr}", raw_data, disabled: disabled?(patient_attr))
  end

  def disabled?(patient_attr)
    ImportRow::CANNOT_EDIT.include?(patient_attr.to_sym)
  end
end
