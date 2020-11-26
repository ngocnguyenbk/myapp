@users.each do |user|
  json.set! user.id, user.full_name
end
