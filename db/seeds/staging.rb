ActiveRecord::Base.connection.execute("TRUNCATE #{Floor.table_name}")
ActiveRecord::Base.connection.execute("TRUNCATE #{Room.table_name}")
ActiveRecord::Base.connection.execute("TRUNCATE #{User.table_name}")
ActiveRecord::Base.connection.execute("TRUNCATE #{Contract.table_name}")
# Create 7 floors
(1..7).each do |i|
  Floor.create!(floor_number: i)
end

# Create 27 rooms
rooms = []
Floor.all.each do |floor|
  5.times do |r_i|
    room_ordinal_number = r_i + 1
    rooms << floor.rooms.build(
      room_number: "#{floor.floor_number}0#{r_i}",
      status: rand(0..2),
      area: rand(25..30),
      floor_id: floor.id
      )
  end
end

Room.import! rooms

# Create users
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

# Update room holder_id
Room.where(status: 0).each do |room|
  room.update(holder_id: room.users.sample.id)
end

# Create contracts for each room
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
