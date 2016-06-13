FactoryGirl.define do
  factory :session do
    association :user

    token { Faker::Lorem.characters(10) }
  end
end