require "rails_helper"

RSpec.describe UsersForm, type: :model do
  describe "::name" do
    subject { described_class.name }
    it { is_expected.to eq "User" }
  end

  describe "Validation" do
    it { should validate_presence_of(:birthday).with_message(:blank) }
    it { should validate_presence_of(:email).with_message(:blank) }
    it { should validate_presence_of(:first_name).with_message(:blank) }
    it { should validate_presence_of(:last_name).with_message(:blank) }
    it { should validate_presence_of(:phone).with_message(:blank) }
    it { should validate_presence_of(:room_id).with_message(:blank) }

    it { should validate_numericality_of(:phone) }

    it { should validate_length_of(:phone).is_at_least(9) }
    it { should validate_length_of(:phone).is_at_most(11) }
  end

  describe "Delegate" do
    it { should delegate_method(:persisted?).to(:user) }
  end

  describe "#save" do
    let(:user_form) { described_class.new }
    before do
      user
      user_form.record = user
      user_form.assign_from_model
    end

    context "when invalid" do
      let(:user) { FactoryBot.build :user, email: "" }

      subject { user_form.save }

      it { is_expected.to eq false }
    end

    context "when create user valid" do
      let(:room) { FactoryBot.create :room }
      let(:user) { FactoryBot.build :user, room_id: room.id }

      subject { user_form.save }

      it { is_expected.to eq true }
    end

    context "when update user valid" do
      let(:room) { FactoryBot.create :room }
      let(:user) { FactoryBot.create :user, room_id: room.id }

      subject { user_form.save }

      it { is_expected.to eq true }
    end
  end
end
