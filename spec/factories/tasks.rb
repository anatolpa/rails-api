FactoryGirl.define do
  factory :task do
    association :user
    association :image

    operation { Faker::Internet.email }
    params { Faker::Internet.password }
  end
end