FactoryBot.define do
  factory :contract do
    id { 1 }
    room_price { 12_345_678 }
    deposited_money { 500_000 }
    started_date { "19/11/2020" }
    ended_date { "19/03/2021" }
    association :room, factory: :room
    association :holder, factory: :user
    active { true }
  end
end
