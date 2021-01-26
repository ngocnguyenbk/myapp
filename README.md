# BOARDING HOUSE MANAGEMENT SYSTEM

## Build Environment

### Development (Docker)

1. Git clone
```
git clone git@github.com:ngocnguyenbk/myapp.git
```
2. Config database
```
cp config/database_example.yml config/database.yml
```

3. Build and run Docker
```
  docker-compose build
  docker-compose up
  # Open new terminal
    docker-compose exec web bash
    bundle install (Only the first time)
    rails db:create db:migrate db:seed
    rails assets:precompile
```

4. Starting server
```
rails s -b 0.0.0.0
```

5. [Optional] Start webpack-dev-server
```
# Open new terminal
  docker-compose exec web bash
  bin/webpack-dev-server
```

When server running, open (http://localhost:3000)
