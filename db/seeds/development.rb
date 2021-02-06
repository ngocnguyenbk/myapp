ActiveRecord::Base.connection.execute("TRUNCATE #{Floor.table_name}")
Rake::Task["default_data:create_floors"].invoke
ActiveRecord::Base.connection.execute("TRUNCATE #{Room.table_name}")
Rake::Task["default_data:create_rooms"].invoke
ActiveRecord::Base.connection.execute("TRUNCATE #{User.table_name}")
Rake::Task["default_data:create_users"].invoke
Rake::Task["default_data:update_room_holder_id"].invoke
ActiveRecord::Base.connection.execute("TRUNCATE #{Contract.table_name}")
Rake::Task["default_data:contracts"].invoke
ActiveRecord::Base.connection.execute("TRUNCATE #{Invoice.table_name}")
Rake::Task["default_data:create_invoices"].invoke
ActiveRecord::Base.connection.execute("TRUNCATE #{ServiceItem.table_name}")
Rake::Task["default_data:create_service_items"].invoke
ActiveRecord::Base.connection.execute("TRUNCATE #{ResourceItem.table_name}")
Rake::Task["default_data:create_resource_items"].invoke
