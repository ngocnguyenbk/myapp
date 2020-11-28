require "rails_helper"

RSpec.describe DetailContractSerializer do
  let(:contract) { FactoryBot.create :contract }
  let(:serializer) { DetailContractSerializer.new(contract) }
  let(:result) do
    { "months_remaining" => 2, "months_rented" => 3, "total_moneys" => 37_037_034 }
  end

  before { allow(Time).to receive(:now).and_return("2021-01-25".to_time) }

  subject { JSON.parse(serializer.to_json) }

  it { is_expected.to eq result }
end
