require "rails_helper"
RSpec.describe User, type: :model do
  describe "Associations" do
    it { should belong_to(:room) }
  end

  let(:user) do
    FactoryBot.create :user, created_at: "12/11/2020", birthday: "27/11/1998",
                             first_name: "Jack", last_name: "Sparrow"
  end

  before { user }

  describe "#created_date" do
    subject { user.created_date.format_with_separate }

    it { is_expected.to eq "12/11/2020" }
  end

  describe "#birth_day" do
    subject { user.birth_day.format_with_separate }

    it { is_expected.to eq "27/11/1998" }
  end

  describe "#full_name" do
    subject { user.full_name }

    it { is_expected.to eq "Jack Sparrow" }
  end

  describe "#destroy restore user" do
    before do
      user.destroy
      user.restore
    end

    subject { user.active }

    it { is_expected.to eq true }
  end
end
