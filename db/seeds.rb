# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
    name = Faker::Games::Pokemon.name
    email = Faker::Internet.email
    password = "123456"
    admin = Faker::Boolean.boolean
    User.create!(name: name,
                 email: email,
                 password: password,
                 admin: admin
                 )
end
10.times do |n|
    name = Faker::Games::Pokemon.name
    Label.create!(name: name,
                 user_id: 0,
                )
end
10.times do |n|
    name = Faker::Games::Pokemon.name
    detail = Faker::Book.title
    expired_at = Faker::Date.between(from: '2021-09-23', to: '2023-09-25')
    Task.create!(name: name,
                detail: detail,
                user_id: User.first.id,
                expired_at: expired_at,
                )
end