require "rails_helper"

RSpec.describe BatchCreate::UsersForm, type: :model do
  describe "::name" do
    subject { described_class.name }
    it { is_expected.to eq "BatchCreate::User" }
  end

  describe "#save" do
    context "when invalid" do
      let(:params) do
        {
          user_attributes: {
            "0" => {
              first_name: "Dang",
              last_name: "Thinh",
              email: "",
              phone: "0324543423",
              birthday: "19950303",
              identity_card: "12345678",
              room_id: "1"
            }
          }
        }
      end
      let(:user_form) { described_class.new(params) }

      subject { user_form.save }

      it { is_expected.to eq false }
    end

    context "when create user valid" do
      let(:params) do
        {
          user_attributes: {
            "0" => {
              first_name: "Jack",
              last_name: "Sparrow",
              email: "jack@gmail.com",
              phone: "0324543423",
              birthday: "19950303",
              identity_card: "12345678",
              room_id: "1"
            }
          }
        }
      end
      let(:user_form) { described_class.new(params) }
      let(:room) { FactoryBot.create :room }

      before { room }

      it do
        expect { user_form.save }.to change { User.count }.by(1)
      end
    end
  end
end
