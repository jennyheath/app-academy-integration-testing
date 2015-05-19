FactoryGirl.define do
  factory :goal do
    body { Faker::Lorem.sentence(word_count = 10) }
    user_id { 1 }
    visibility { "y" }
  end
end
