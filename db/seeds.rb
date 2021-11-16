# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "Rafael Carrilho", email: "rafael.carrilho@id.uff.br", password: "12345678", password_confirmation: "12345678", is_master: true, birthdate: "16/02/2000", marital_status: 0, location: "Rua Francisco Fonseca, 132, Pita, São Gonçalo, Rio de Janeiro", branch: 1, member_since: "15/11/2021", is_baptized: true)
