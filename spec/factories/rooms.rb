FactoryBot.define do
  factory :room do
    room_number { 1 }
    association :floor, factory: :floor
  end
end
