require "rails_helper"
RSpec.describe Floor, type: :model do
  describe "Associations" do
    it { should have_many(:rooms) }
  end
end
