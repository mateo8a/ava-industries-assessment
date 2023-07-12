class ImportCell < ApplicationRecord
  belongs_to :migration
  belongs_to :import_row
  belongs_to :import_header
  after_save :check_if_valid_data, unless: :skip_valid_data_callback

  delegate :clinic, to: :migration, allow_nil: false
  delegate :patient_attribute, to: :import_header

  def self.get_by_patient_attr(patient_attribute)
    import_header_id = ImportHeader.where(patient_attribute: patient_attribute).pluck(:id)
    find_by(import_header_id: import_header_id)
  end

  attr_accessor :skip_valid_data_callback

  def check_if_valid_data
    self.raw_data = raw_data&.strip
    case import_header.patient_attribute.to_sym
    when :health_identifier_number
      validate_on_health_identifier_number
    when :health_identifier_province, :address_province
      validate_and_convert_province_code
    when :first_name, :last_name
      validate_name
    when :phone
      validate_phone_number
    when :email
      validate_email
    when :address_city
      validate_city
    when :address_postal_code
      validate_postal_code
    when :date_of_birth
      validate_date_of_birth
    when :sex
      validate_sex
    end
    self.skip_valid_data_callback = true
    self.save! if self.changed?
    self.skip_valid_data_callback = false
  end

  private 

  def validate_on_health_identifier_number
    if raw_data.nil? || (raw_data.to_i == 0)
      import_row.add_invalid_warning("health_identifier_number")
    elsif migration.clinic.patients.find_by(health_identifier_number: raw_data.to_i)
      import_row.add_conflict_warning("health_identifier_number")
    end
  end

  def validate_and_convert_province_code
    def province_attr = import_header.patient_attribute
    if raw_data.nil?
      import_row.add_invalid_warning(province_attr)
    else
      if raw_data.length == 2
        if provinces_hash.values.include?(raw_data.upcase)
          self.raw_data = raw_data.upcase
          # self.save!
        else
          import_row.add_invalid_warning(province_attr) 
        end
      else
        import_row.add_invalid_warning(province_attr) unless provinces_hash[raw_data.downcase]
        self.raw_data = raw_data.titleize
      end
    end
  end

  def validate_name
    if raw_data.nil?
      import_row.add_invalid_warning(import_header.patient_attribute)
      return
    end
    self.raw_data = raw_data.titleize
  end

  def validate_email
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    import_row.add_invalid_warning("email") unless email_regex =~ raw_data
  end

  def validate_phone_number
    return if raw_data.nil?
    phone_number = raw_data.gsub("-", "")
    phone_regex = /\A1\d{10}\z|\A\d{10}\z/
    if phone_regex =~ phone_number
      self.raw_data = phone_number
      # self.save!
    else
      import_row.add_invalid_warning("phone") 
    end
  end

  def validate_city
    return if raw_data.nil?
    self.raw_data = raw_data.capitalize
    # self.save!
  end

  def validate_postal_code
    postal_code = raw_data
    return if postal_code.nil?
    import_row.add_invalid_warning("address_postal_code") if (postal_code.length < 6 || postal_code.length > 7)
    postal_code = postal_code.insert(3, " ") if postal_code.length == 6
    postal_code = postal_code.upcase
    postal_code_regex = /\A[A-Z]\d[A-Z][ -]?\d[A-Z]\d\z/
    import_row.add_invalid_warning("address_postal_code") unless postal_code_regex =~ postal_code
    self.raw_data = postal_code
    # self.save! if self.changed?
  end

  def validate_date_of_birth
    if raw_data.nil?
      import_row.add_invalid_warning("date_of_birth")
      return
    end
    Date.parse(raw_data)
  rescue Date::Error
    import_row.add_invalid_warning("date_of_birth")
  end

  def validate_sex
    if !["M", "F", "m", "f"].include?(raw_data)
      import_row.add_invalid_warning("sex") 
      return
    end
    self.raw_data = raw_data.upcase
    # self.save! if self.changed?
  end

  def provinces_hash
    {
      "alberta" => "AB", "british columbia" => "BC", "manitoba" => "MB", "new brunswick" => "NB", "newfoundland and labrador" => "NL",
      "northwest territories" => "NT", "nova scotia" => "NS", "nunavut" => "NU", "ontario" => "ON", "prince edward island" => "PE",
      "quebec" => "QC", "saskatchewan" => "SK", "yukon" => "YT"
    }
  end
end
