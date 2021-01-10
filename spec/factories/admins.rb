FactoryBot.define do
  factory :admin do
    full_name { "Jack Sparrow" }
    email { "jack_sparrow@gmail.com" }
    phone { "0123456789" }
    birthday { rand(18..40).years.ago }
    role { "admin" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end
