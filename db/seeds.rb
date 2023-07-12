# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

{health_identifier_number: [:health_identifier_number],
  health_identifier_province: [:health_identifier_province],
  first_name: [:first_name],
  middle_name: [:middle_name],
  last_name: [:last_name, :family_name],
  phone: [:phone, :telephone, :cellphone],
  email: [:email],
  address_one: [:address_one, :address_1],
  address_two: [:address_two, :address_2],
  address_province: [:address_province],
  address_city: [:address_city],
  address_postal_code: [:address_postal_code],
  date_of_birth: [:birthday, :date_of_birth],
  sex: [:sex],
}.each do |patient_attr, parsed_csv_headers|
  import_header = ImportHeader.create!(patient_attribute: patient_attr)
  parsed_csv_headers.each do |parsed_header|
    ImportHeaderMatcher.create!(import_header_id: import_header.id, parsed_csv_header: parsed_header)
  end
end

st_francis_clinic = Clinic.create!(name: "St. Francis Clinic")
st_francis_clinic.doctors.create!(first_name: "David", last_name: "Thomson", email: "example@example.com", password: "password")