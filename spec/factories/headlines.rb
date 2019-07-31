FactoryBot.define do
  factory :headline do
    text { Faker::Lorem.sentence(5, true, 5) }
    origin { Faker::Movies::StarWars.character }
    publisher { Faker::Games::WorldOfWarcraft.hero }
  end
end
