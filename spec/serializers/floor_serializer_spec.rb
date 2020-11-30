require "rails_helper"

RSpec.describe FloorSerializer do
  let(:floor) { FactoryBot.create :floor }
  let(:result) do
    { "floor_number" => 1, "rooms" => [] }
  end
  let(:serializer) { FloorSerializer.new(floor) }

  subject { JSON.parse(serializer.to_json) }

  it { is_expected.to eq result }
end
