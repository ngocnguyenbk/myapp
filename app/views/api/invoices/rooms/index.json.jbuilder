@rooms.each do |room|
  json.set! room.id, room.room_number
end
