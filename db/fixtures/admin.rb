Admin.seed do |admin|
  admin.id = 1
  admin.full_name = "Supper Admin"
  admin.email = ENV["ADMIN_EMAIL"]
  admin.phone = "0123456789"
  admin.birthday = "06011996"
  admin.password = ENV["ADMIN_PASSWORD"]
  admin.role = 0
end
