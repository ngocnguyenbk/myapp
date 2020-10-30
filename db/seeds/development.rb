ActiveRecord::Base.connection.execute("TRUNCATE #{Floor.table_name}")
Rake::Task["default_data:create_floors"].invoke
ActiveRecord::Base.connection.execute("TRUNCATE #{Room.table_name}")
Rake::Task["default_data:create_rooms"].invoke
ActiveRecord::Base.connection.execute("TRUNCATE #{User.table_name}")
Rake::Task["default_data:create_users"].invoke
Rake::Task["default_data:create_admin"].invoke
