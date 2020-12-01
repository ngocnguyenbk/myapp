require "rails_helper"

RSpec.describe FloorSerializer do
  let(:floor) { FactoryBot.create :floor }

  let(:serializer) { FloorSerializer.new(floor) }

  subject { serializer }

  it {
    is_expected.to include(floor_number: floor.floor_number)
  }
end
