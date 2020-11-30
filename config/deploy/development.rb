set :stage, :development
set :rails_env, :staging
set :user, :deploy
set :deploy_to, "/var/www/myapp"

set :branch, :develop

server "52.91.120.154", user: fetch(:user), roles: %w[app db batch]

set :ssh_options,
    keys: %w[.ssh/deploy_cloudwatch_details.pem],
    forward_agent: true,
    user: fetch(:user)
