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
        j += 100
        5.times do |i|
          rooms << floor.rooms.build(
            room_number: j + i,
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
          started_date: Faker::Date.between(from: 2.years.ago, to: 1.year.ago),
          ended_date: Faker::Date.between(from: Time.zone.today, to: 2.years.since)
        )
      end
    end

    task create_invoices: :environment do
      invoices = []
      Contract.all.each do |contract|
        5.times do |i|
          invoices << contract.invoices.build(
            date_export: i.month.ago,
            reduce: 300_000,
            total: 5_000_000
          )
        end
      end

      Invoice.import! invoices
    end

    task create_service_items: :environment do
      parking_fees = []
      internets = []
      services = []

      Invoice.all.each do |invoice|
        qty = rand(1..3)
        unit_price_parking_fee = Settings.unit_price.parking_fee
        unit_price_internet = Settings.unit_price.internet
        unit_price_service = Settings.unit_price.service

        parking_fees << Item::ParkingFee.new(
          invoice_id: invoice.id,
          quantity: qty,
          unit_price: unit_price_parking_fee,
          total: unit_price_parking_fee * qty,
          unit: "x"
        )

        internets << Item::Internet.new(
          invoice_id: invoice.id,
          quantity: qty,
          unit_price: unit_price_internet,
          total: unit_price_internet * qty,
          unit: "x"
        )

        services << Item::Service.new(
          invoice_id: invoice.id,
          quantity: qty,
          unit_price: unit_price_service,
          total: unit_price_service * qty,
          unit: "x"
        )
      end

      ServiceItem.import!(parking_fees + internets + services)
    end

    task create_resource_items: :environment do
      electrics = []
      waters = []
      begin_number = 0
      end_number = 100

      Invoice.all.each do |invoice|
        qty = end_number - begin_number
        unit_price_electric = Settings.unit_price.electric
        unit_price_water = Settings.unit_price.water

        electrics << Item::Electric.new(
          invoice_id: invoice.id,
          begin_number: begin_number,
          end_number: end_number,
          quantity: qty,
          total: unit_price_electric * qty,
          unit_price: unit_price_electric,
          unit: "x"
        )

        waters << Item::Water.new(
          invoice_id: invoice.id,
          begin_number: begin_number,
          end_number: end_number,
          quantity: qty,
          total: unit_price_water * qty,
          unit_price: unit_price_water,
          unit: "x"
        )

        begin_number = end_number + 1
        end_number = begin_number + rand(50..70)
      end

      ResourceItem.import!(electrics + waters)
    end
  end
end
# rubocop:enable Metrics/BlockLength
