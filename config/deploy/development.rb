set :stage, :development
set :rails_env, :staging
set :user, :deploy
set :deploy_to, "/var/www/myapp"

set :branch, :develop

server "34.195.239.8", user: fetch(:user), roles: %w[app db batch]

set :ssh_options,
    keys: %w[.ssh/deploy_cloudwatch_details.pem],
    forward_agent: true,
    user: fetch(:user)
