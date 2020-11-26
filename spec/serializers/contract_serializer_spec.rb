require "rails_helper"

RSpec.describe ContractSerializer do
  let(:room) { FactoryBot.create :room, room_number: 10, status: "deposited", holder_id: 1 }
  let(:user) { FactoryBot.create :user, id: 1, room_id: room.id }
  let(:contract) { FactoryBot.create :contract, holder_id: user.id, room_id: room.id }

  let(:serializer) { ContractSerializer.new(contract) }

  subject { serializer }

  it {
    is_expected.to include(deposited_money: 500_000, end_date: "19/03/2021", holder_name: "Jack Sparrow", id: 1,
                           room_number: 10, room_price: 12_345_678, start_date: "19/11/2020")
  }
end
