begin
  ActiveRecord::Base.connection.execute "SET FOREIGN_KEY_CHECKS=0;"

  ["all", Rails.env].each do |seed|
    seed_file = Rails.root.join("db/seeds/#{seed}.rb")
    if File.exist?(seed_file)
      puts "*********Loading #{seed} seed data*********"
      require seed_file
    end
  end
rescue ActiveRecord::RecordInvalid => e
  puts e.record.errors.full_messages
ensure
  ActiveRecord::Base.connection.execute "SET FOREIGN_KEY_CHECKS=1;"
  puts "*********Done*********"
end
