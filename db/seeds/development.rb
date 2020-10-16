# Create User
ActiveRecord::Base.connection.execute("TRUNCATE #{User.table_name}")
Rake::Task["default_data:create_user"].invoke
