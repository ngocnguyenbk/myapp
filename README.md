# BOARDING HOUSE MANAGEMENT SYSTEM

## Build Environment

### Development

1. Git clone
```
git clone git@github.com:ngocnguyenbk/myapp.git
```
2. [Install RVM](https://gorails.com/setup/ubuntu/20.04#ruby-rvm)

3. Install Ruby 2.6.6
```
rvm install 2.6.6
```
4. Install Bundler
```
gem install bundler -v 2.1.4
```
5. Install Rails 6.0.3.3
```
gem install rails -v 6.0.3.3
```
5. [Install Mysql](https://gorails.com/setup/ubuntu/20.04#database)

6. Install Nodejs 10.19.0
```
curl -sL https://deb.nodesource.com/setup_10.x | bash -
```
7. Install Yarn 1.22.5
```
sudo apt install --no-install-recommends yarn
```
8. Build system

```
cd path/to/myapp
cp config/database_example.yml config/database.yml
bundle install
rails db:create db:migrate db:seed
yarn install
rails assets:precompile
```
9. Run system
```
rails s
```
When server running, open (http://localhost:3000)
