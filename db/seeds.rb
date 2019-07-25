# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
require 'faker'

10.times do
  Headline.create(
      origin: Faker::Ancient.titan,
      publisher: Faker::Name.name_with_middle,
      text: Faker::Lorem.sentence(3, false, 2)

  )
end

150.times do
  Comment.create(
      author: Faker::Movies::StarWars.character,
      text: Faker::Lorem.sentence(50,true,90),
      up_vote: rand(50),
      down_vote: rand(50),
      headline_id: rand(1..10)
  )
end