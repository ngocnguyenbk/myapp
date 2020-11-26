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
            room_id: room.id,
            updated_at: rand(32..60).days.ago,
            created_at: rand(32..60).days.ago
          )
        end
      end
      User.import! users
    end

    task update_room_holder_id: :environment do
      Room.where(status: 0).each do |room|
        room.update(holder_id: room.users.sample.id)
      end
    end

    task contracts: :environment do
      Room.where(status: 0).each do |room|
        Contract.create!(
          holder_id: room.holder_id,
          room_id: room.id,
          room_price: Faker::Number.decimal(l_digits: 7, r_digits: 1),
          deposited_money: Faker::Number.decimal(l_digits: 6, r_digits: 1),
          started_date: Time.zone.now,
          ended_date: rand(1..2).years.since
        )
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
