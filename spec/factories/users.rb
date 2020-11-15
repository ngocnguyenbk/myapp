FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    phone { Faker::Base.unique.numerify("84#######") }
    identity_card { Faker::Base.numerify("##########") }
    birthday { rand(18..40).years.ago }
    association :room, factory: :room
    active { true }
  end
end
