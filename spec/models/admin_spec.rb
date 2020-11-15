require "rails_helper"
RSpec.describe Admin, type: :model do
  describe "Validation" do
    it { should validate_presence_of(:full_name).with_message(:blank) }
    it { should validate_presence_of(:email).with_message(:blank) }
    it { should validate_presence_of(:password).with_message(:blank) }
    it { should validate_presence_of(:role).with_message(:blank) }

    it { should validate_numericality_of(:phone) }

    it { should validate_length_of(:phone).is_at_least(9) }
    it { should validate_length_of(:phone).is_at_most(11) }
  end
end
