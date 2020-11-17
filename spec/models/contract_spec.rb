require "rails_helper"
RSpec.describe Contract, type: :model do
  describe "Associations" do
    it { should belong_to(:holder).class_name(User.name).optional }
    it { should belong_to(:room).class_name(Room.name).optional }
  end

  describe "Delegate" do
    it { should delegate_method(:room_number).to(:room).with_prefix.allow_nil }
    it { should delegate_method(:full_name).to(:holder).with_prefix.allow_nil }
  end

  let(:contract) { FactoryBot.create :contract }

  describe "#start_date" do
    subject { contract.start_date.format_with_separate }

    it { is_expected.to eq "19/11/2020" }
  end

  describe "#end_date" do
    subject { contract.end_date.format_with_separate }

    it { is_expected.to eq "19/03/2021" }
  end

  before { allow(Time).to receive(:now).and_return("2021-01-25".to_time) }

  describe "#total_months_rented" do
    subject { contract.total_months_rented }

    it { is_expected.to eq 3 }
  end

  describe "#total_months_remaining" do
    subject { contract.total_months_remaining }

    it { is_expected.to eq 2 }
  end
end
