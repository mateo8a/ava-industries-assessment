module ImportRowsHelper
  def cell_text_tag(patient_attr, raw_data)
    cell_text_tag_disabled(patient_attr, raw_data, disabled?(patient_attr))
  end

  def cell_text_tag_disabled(patient_attr, raw_data, disabled)
    text_field_tag("row_data[#{patient_attr}", raw_data, disabled: disabled)
  end

  def disabled?(patient_attr)
    ImportRow::CANNOT_EDIT.include?(patient_attr.to_sym)
  end
end
