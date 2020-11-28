require "rails_helper"

RSpec.describe RoomSerializer do
  let(:room) { FactoryBot.create :room, room_number: 10, status: "empty", holder_id: 1, area: "35" }
  let(:user) { FactoryBot.create :user, id: 1, room_id: room.id }
  let(:result) do
    { "area" => 35.0, "holder_id" => 1, "id" => 1, "room_number" => 10, "status" => "empty", "total_users" => 0 }
  end
  let(:serializer) { RoomSerializer.new(room) }

  subject { JSON.parse(serializer.to_json) }

  it { is_expected.to eq result }
end
