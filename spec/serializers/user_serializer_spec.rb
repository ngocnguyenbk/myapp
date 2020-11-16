require "rails_helper"

RSpec.describe UserSerializer do
  let(:user) do
    FactoryBot.create :user, id: 1, first_name: "Jack", last_name: "Sparrow", email: "jack@gmail.com",
                             phone: "0123456789", birthday: "01/01/1999", active: true, created_at: "01/01/2020"
  end

  let(:serializer) { UserSerializer.new(user) }

  subject { serializer }

  it {
    is_expected.to include(id: 1, full_name: "Jack Sparrow", first_name: "Jack", last_name: "Sparrow",
                           email: "jack@gmail.com", phone: "0123456789", birth_day: "01/01/1999",
                           created_date: "01/01/2020", status_active: true)
  }
end
