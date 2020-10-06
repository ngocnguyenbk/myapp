source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.6"

gem "rails", "~> 6.0.2", ">= 6.0.2.2"
gem "mysql2"
gem "puma", "~> 4.1"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 4.0"
gem "jbuilder", "~> 2.7"
gem "dotenv-rails"
gem "slim"
gem "bootsnap", ">= 1.4.2", require: false
gem "paranoia"

group :development, :test do
  gem "pry-rails"
  gem "pry", "0.13.1"
end

group :development do
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "capistrano"
  gem "capistrano3-puma"
  gem "capistrano-rails", require: false
  gem "capistrano-yarn"
  gem "capistrano-bundler", require: false
  gem "capistrano-rvm"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
