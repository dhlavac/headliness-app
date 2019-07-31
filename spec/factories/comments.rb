FactoryBot.define do
  factory :comment do
    author { Faker::Movies::StarWars.character }
    text { Faker::Lorem.sentence(50,true,90)}
    up_vote { rand(50)}
    down_vote { rand(50)}
    headline_id {rand(1..2)}
  end
end
