require "rails_helper"

RSpec.describe RoomsForm, type: :model do
  describe "::name" do
    subject { described_class.name }
    it { is_expected.to eq "Room" }
  end

  describe "Validation" do
    it { should validate_presence_of(:room_number).with_message(:blank) }
  end

  describe "#save" do
    let(:room_form) { described_class.new }

    before do
      room
      room_form.record = room
      room_form.assign_from_model
    end

    context "when invalid" do
      let(:room) { FactoryBot.build :room, room_number: "" }

      subject { room_form.save }

      it { is_expected.to eq false }
    end

    context "when valid" do
      let(:room) { FactoryBot.build :room }

      subject { room_form.save }

      it { is_expected.to eq true }
    end

    context "when room status is empty" do
      let(:room) { FactoryBot.create :room, status: "empty" }
      let(:user) { FactoryBot.create :user, room_id: room.id, active: true }

      before { user }

      it do
        expect do
          room_form.save
          user.reload
        end.to change(user, :active).from(true).to(false)
      end
    end
  end
end
