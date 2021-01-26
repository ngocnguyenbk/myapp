FactoryBot.define do
  factory :user do
    first_name { "Jack" }
    last_name { "Sparrow" }
    email { Faker::Internet.unique.email }
    phone { Faker::Base.unique.numerify("84#######") }
    identity_card { Faker::Base.numerify("##########") }
    birthday { rand(18..40).years.ago }
    association :room, factory: :room
    active { true }
  end
end
