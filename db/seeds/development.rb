ActiveRecord::Base.connection.execute("TRUNCATE #{Floor.table_name}")
Rake::Task["default_data:create_floors"].invoke
ActiveRecord::Base.connection.execute("TRUNCATE #{Room.table_name}")
Rake::Task["default_data:create_rooms"].invoke
ActiveRecord::Base.connection.execute("TRUNCATE #{User.table_name}")
Rake::Task["default_data:create_users"].invoke
Rake::Task["default_data:update_room_holder_id"].invoke
ActiveRecord::Base.connection.execute("TRUNCATE #{Contract.table_name}")
Rake::Task["default_data:contracts"].invoke
