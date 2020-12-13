require "rails_helper"
RSpec.describe ExtendContractForm, type: :model do
  describe "::name" do
    subject { described_class.name }
    it { is_expected.to eq "ExtendContract" }
  end

  describe "Validation" do
    it { should validate_presence_of(:number_months).with_message(:blank) }
  end

  describe "#save" do
    let(:contract) { FactoryBot.create :contract, ended_date: "13/12/2020" }
    let(:params) { { number_months: "3" } }
    let(:contract_form) { described_class.new(params) }

    before do
      contract_form.record = contract
    end

    it { expect { contract_form.save }.to change(contract, :ended_date).from("13/12/2020".to_date).to("13/03/2021".to_date) }
  end
end
