if Rails.env.production?
  namespace :default_data_prd do
    desc "Create 7 floors from 1 to 7"
    task create_floors: :environment do
      unless Floor.exists?
        (1..7).each do |i|
          Floor.create!(floor_number: i)
        end
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
    end

    desc "Create 27 rooms from 101 to 701"
    task create_rooms: :environment do
      # Create room in floor 1, only room 101

      Floor.first.rooms.find_or_create_by!(room_number: 101, area: 28)

      # Create room in floor 2 to 6, from 201 to 605

      BASIC_FLOOR = {
        rooms: [
          {
            number: 1,
            area: 28
          },
          {
            number: 2,
            area: 25
          },
          {
            number: 3,
            area: 23
          },
          {
            number: 4,
            area: 28
          },
          {
            number: 5,
            area: 28
          }
        ]
      }.freeze
      Floor.where(id: 2..6).each do |floor|
        BASIC_FLOOR[:rooms].each do |room|
          floor.rooms.find_or_create_by!(room_number: (floor.id * 100 + room[:number]), area: room[:area])
        end
      end

      # Create room in floor 7, only room 701

      Floor.find(7).rooms.find_or_create_by!(room_number: 701, area: 28)
    end
  end
end
