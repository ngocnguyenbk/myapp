require "rails_helper"

RSpec.describe RoomSerializer do
  let(:floor) { FactoryBot.create :floor }
  let(:room) { FactoryBot.create :room, room_number: 10, floor_id: floor.id, status: "empty", holder_id: 1, area: "35" }
  let(:user) { FactoryBot.create :user, id: 1, room_id: room.id }
  let(:result) do
    { "area" => 35.0, "holder_id" => 1, "id" => 1, "room_number" => 10, "status" => "empty", "total_users" => 1 }
  end
  let(:serializer) { FloorSerializer.new(floor) }

  before do
    floor
    room
    user
  end

  subject { JSON.parse(serializer.to_json)["rooms"] }

  it { is_expected.to eq [result] }
end
