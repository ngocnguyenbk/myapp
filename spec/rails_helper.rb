require "spec_helper"
require "simplecov"

SimpleCov.start do
  add_filter do |src|
    src.lines.count < 5
  end

  add_filter "controllers"
  add_filter "config"
  add_filter "spec"
  add_filter "validators"

  add_group "Models", "app/models"
  add_group "Forms", "app/forms"
  add_group "Serializers", "app/serializers"
end

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
