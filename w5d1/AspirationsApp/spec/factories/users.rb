FactoryGirl.define do
  factory :user do
    username Faker::Internet.user_name
    password Faker::Internet.password
  end

  factory :nil_user do
    username nil
  end

  factory :nil_password do
    password nil
  end
end
