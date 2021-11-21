# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "Rafael Carrilho", email: "rafael.carrilho@id.uff.br", cpf: "176.699.507-14", rg: "35.596.701-1", password: "12345678", password_confirmation: "12345678", is_master: true, birthdate: "16/02/2000", marital_status: 0, location: "Rua Francisco Fonseca, 132, Pita, São Gonçalo, Rio de Janeiro", branch: 1, member_since: "15/11/2021", is_baptized: true)

20.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    cpf: Faker::IDNumber.brazilian_citizen_number(formatted: true),
    rg: Faker::IDNumber.brazilian_id(formatted: true),
    password: "12345678",
    password_confirmation: "12345678",
    is_manager: false,
    is_master: false,
    birthdate: Faker::Date.between(from: '1960-01-01', to: '2002-12-12'),
    marital_status: rand(0..4),
    location: Faker::Address.full_address,
    branch: rand(0..1),
    member_since: Faker::Date.between(from: '2018-01-01', to: '2021-11-21'),
    is_baptized: true
  )
end

20.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    cpf: Faker::IDNumber.brazilian_citizen_number(formatted: true),
    rg: Faker::IDNumber.brazilian_id(formatted: true),
    password: "12345678",
    password_confirmation: "12345678",
    is_manager: false,
    is_master: true,
    birthdate: Faker::Date.between(from: '1960-01-01', to: '2002-12-12'),
    marital_status: rand(0..4),
    location: Faker::Address.full_address,
    branch: rand(0..1),
    member_since: Faker::Date.between(from: '2018-01-01', to: '2021-11-21'),
    is_baptized: true
  )
end

20.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    cpf: Faker::IDNumber.brazilian_citizen_number(formatted: true),
    rg: Faker::IDNumber.brazilian_id(formatted: true),
    password: "12345678",
    password_confirmation: "12345678",
    is_manager: true,
    is_master: false,
    birthdate: Faker::Date.between(from: '1960-01-01', to: '2002-12-12'),
    marital_status: rand(0..4),
    location: Faker::Address.full_address,
    branch: rand(0..1),
    member_since: Faker::Date.between(from: '2018-01-01', to: '2021-11-21'),
    is_baptized: true
  )
end
