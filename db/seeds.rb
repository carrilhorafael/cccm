# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_user(**args)
  u = User.new(args)
  u.set_default_password
  u.save
end

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

Church.create(
  name: "Pita",
  location: "Rua do Pita, 123, Pita, São Gonçalo, Rio de Janeiro"
)

Church.create(
  name: "Porto",
  location: "Rua do Porto, 123, Porto, São Gonçalo, Rio de Janeiro"
)
titles = ["Pastor(a)", "Obreiro(a)", "Diácono(a)"]
ministeries = ["Louvor", "Obreiros", "Infantil", "Oração"]

Church.find_each do |church|
  actual_members = church.users.length
  actual_leaders = church.leaders.length
  actual_ministeries = church.ministeries.length

  while actual_leaders <= 2
    returned = create_user(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      title: titles[rand(0..2)],
      phone: "(21)9#{rand(7000..9999)}-#{rand(1000..9999)}",
      birthdate: Faker::Date.between(from: '1960-01-01', to: '2002-12-12'),
      marital_status: rand(0..4),
      location: Faker::Address.full_address,
      member_since: Faker::Date.between(from: '2018-01-01', to: '2021-11-21'),
      is_baptized: true,
      is_leader: true,
      church: church
    )
    puts "#{church.name} - members: #{actual_members} - leaders: #{actual_leaders}"
    actual_leaders += 1 if returned
    actual_members += 1 if returned
  end
  min_members = rand(20..40)

  while actual_members < min_members
    returned = create_user(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      title: "Membro",
      phone: "(21)9#{rand(7000..9999)}-#{rand(1000..9999)}",
      birthdate: Faker::Date.between(from: '1960-01-01', to: '2002-12-12'),
      marital_status: rand(0..4),
      location: Faker::Address.full_address,
      member_since: Faker::Date.between(from: '2018-01-01', to: '2021-11-21'),
      is_baptized: true,
      is_leader: false,
      church: church
    )
    puts "#{church.name} - members: #{actual_members}"
    actual_members += 1 if returned
  end

  ministeries.each do |ministery|
    Ministery.create(
      name: ministery,
      description: "Essa é uma descrição fake para fazer um teste",
      church: church
    )
  end
end

