require "rails_helper"

RSpec.describe RoomSerializer do
  let(:room) { FactoryBot.create :room, room_number: 10, status: "empty", holder_id: 1, area: "35" }
  let(:user) { FactoryBot.create :user, id: 1, room_id: room.id }

  let(:serializer) { RoomSerializer.new(room) }

  subject { serializer }

  it {
    is_expected.to include(id: room.id, room_number: 10, total_users: 1,
                           status: "empty", holder_id: user.id, area: 35.0)
  }
end
