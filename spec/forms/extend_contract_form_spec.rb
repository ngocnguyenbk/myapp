require "rails_helper"
RSpec.describe ExtendContractForm, type: :model do
  describe "::name" do
    subject { described_class.name }
    it { is_expected.to eq "ExtendContract" }
  end

  describe "Validation" do
    let(:params) { {} }
    let(:admin) { double(:admin, id: 1) }
    subject { described_class.new(params, admin) }

    it { should validate_presence_of(:number_months).with_message(:blank) }
  end

  describe "#save" do
    let(:contract) { FactoryBot.create :contract, ended_date: "13/12/2020" }
    let(:params) { { number_months: "3" } }
    let(:admin) { FactoryBot.create :admin }

    let(:contract_form) { described_class.new(params, admin) }

    subject { contract_form.save }

    context "when step = confirmation" do
      before do
        contract_form.step = "confirmation"
      end

      it { is_expected.to eq true }
    end

    context "when step = done" do
      before do
        contract_form.record = contract
        contract_form.step = "done"
      end

      it { is_expected.to eq true }
    end
  end
end
