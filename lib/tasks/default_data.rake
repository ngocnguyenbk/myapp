require "faker"
# rubocop:disable Metrics/BlockLength
unless Rails.env.production?
  namespace :default_data do
    task create_floors: :environment do
      (1..7).each do |i|
        Floor.create!(floor_number: i)
      end
    end

    task create_rooms: :environment do
      rooms = []
      j = 0
      Floor.all.each do |floor|
        5.times do |_i|
          j += 1
          rooms << floor.rooms.build(
            room_number: j,
            status: rand(0..2),
            area: rand(25..40),
            floor_id: floor.id
          )
        end
      end

      Room.import! rooms
    end

    task create_users: :environment do
      users = []
      Room.where(status: 0).each do |room|
        3.times do |_i|
          users << room.users.build(
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            phone: Faker::Base.numerify("84#######"),
            identity_card: Faker::Base.numerify("##########"),
            birthday: rand(18..40).years.ago,
            password: "654321",
            password_confirmation: "654321",
            room_id: room.id,
            updated_at: rand(32..60).days.ago,
            created_at: rand(32..60).days.ago
          )
        end
      end
      User.import! users
    end
  end
end
# rubocop:enable Metrics/BlockLength
