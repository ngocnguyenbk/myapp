require "rails_helper"

RSpec.describe DetailContractSerializer do
  let(:contract) { FactoryBot.create :contract }
  let(:serializer) { DetailContractSerializer.new(contract) }

  before { allow(Time).to receive(:now).and_return("2021-01-25".to_time) }

  subject { serializer }

  it { is_expected.to include(months_rented: 3, months_remaining: 2, total_moneys: 37_037_034) }
end
