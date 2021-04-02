require "rails_helper"
# rubocop:disable Metrics/BlockLength
RSpec.describe ContractsForm, type: :model do
  describe "::name" do
    subject { described_class.name }
    it { is_expected.to eq "Contract" }
  end

  describe "Validation" do
    let(:params) { {} }
    let(:admin) { double(:admin, id: 1) }
    subject { described_class.new(params, admin) }

    it { should validate_presence_of(:holder_id).with_message(:blank) }
    it { should validate_presence_of(:room_id).with_message(:blank) }
    it { should validate_presence_of(:room_price).with_message(:blank) }
    it { should validate_presence_of(:started_date).with_message(:blank) }
    it { should validate_presence_of(:ended_date).with_message(:blank) }
  end

  describe "Delegate" do
    let(:params) { {} }
    let(:admin) { double(:admin, id: 1) }
    subject { described_class.new(params, admin) }

    it { should delegate_method(:persisted?).to(:contract) }
  end

  describe "#save" do
    let(:admin) { FactoryBot.create :admin }
    let(:contract_form) { described_class.new(params, admin) }
    let(:user) { FactoryBot.create :user, id: 2 }
    let(:room) { FactoryBot.create :room, id: 2 }

    before do
      user
      room
    end

    context "when invalid" do
      let(:params) do
        {
          holder_id: 2, room_id: 2, room_price: "", started_date: "19/11/2020", ended_date: "19/02/2021"
        }
      end

      subject { contract_form.save }

      it { is_expected.to eq false }
    end

    context "when valid" do
      let(:params) do
        {
          holder_id: 2, room_id: 2, room_price: "1000", started_date: "19/11/2020", ended_date: "19/02/2021"
        }
      end

      subject { contract_form.save }

      it { is_expected.to eq true }
    end

    context "update status room to hired" do
      let(:params) do
        {
          holder_id: 2, room_id: 2, room_price: "1000", started_date: "19/11/2020", ended_date: "19/02/2021"
        }
      end

      before { room.update!(status: "empty") }

      it do
        expect do
          contract_form.save
          room.reload
        end.to change(room, :status).from("empty").to("hired")
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
