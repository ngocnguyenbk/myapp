require "rails_helper"
RSpec.describe Room, type: :model do
  describe "Associations" do
    it { should belong_to(:floor) }
    it { should have_many(:users) }
  end
end
