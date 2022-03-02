# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

church = Church.create(
  name: "Brasilândia",
  location: "Rua da Brasilandia, 123, Brasilandia, São Gonçalo, Rio de Janeiro",
  is_head: true
)

User.create(
  name: "Julio",
  title: "Pastor",
  email: "admin@email.com.br",
  phone: "(21)9#{rand(7000..9999)}-#{rand(1000..9999)}",
  password: "12345678",
  password_confirmation: "12345678",
  birthdate: "16/02/1970",
  marital_status: 1,
  location: "Rua do Admin, 123, São Gonçalo, Rio de Janeiro",
  church: Church.first,
  member_since: "15/11/2018",
  is_baptized: true,
  access_garantied_at: Time.zone.now,
  access_garantied_by: "Sistema",
  president_pastor: true,
  is_leader: true
)



# 20.times do
#   u = User.new(
#     name: Faker::Name.name,
#     email: Faker::Internet.email,
#     title: "Pastor",
#     phone: "(21)9#{rand(7000..9999)}-#{rand(1000..9999)}",
#     birthdate: Faker::Date.between(from: '1960-01-01', to: '2002-12-12'),
#     marital_status: rand(0..4),
#     location: Faker::Address.full_address,
#     member_since: Faker::Date.between(from: '2018-01-01', to: '2021-11-21'),
#     is_baptized: true,
#     church: Church.first
#   )
#   u.set_default_password
#   u.save
# end


