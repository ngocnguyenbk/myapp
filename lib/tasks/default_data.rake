require "faker"

unless Rails.env.production?
  namespace :default_data do
    task create_user: :environment do
      100.times do |_i|
        User.create! first_name: Faker::Name.first_name,
                     last_name: Faker::Name.last_name,
                     email: Faker::Internet.email,
                     phone: Faker::Base.numerify("84#######"),
                     birthday: rand(18..40).years.ago,
                     password: "654321",
                     password_confirmation: "654321",
                     updated_at: rand(32..60).days.ago,
                     created_at: rand(32..60).days.ago
      end
    end
  end
end
