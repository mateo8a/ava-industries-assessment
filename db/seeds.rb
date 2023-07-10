# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

st_francis_clinic = Clinic.create(name: "St. Francis Clinic")
doctor = Doctor.new(first_name: "David", last_name: "Thomson", email: "example@example.com", password: "password")
doctor.clinic = st_francis_clinic
doctor.save!