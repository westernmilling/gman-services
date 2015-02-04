lock '3.3.5'
require 'yaml'
require 'rails'

load_params = YAML::load_file('config/application.yml')
server_params = load_params[Rails.env.to_s].symbolize_keys

set :application, server_params[:application]
set :repo_url, server_params[:repo_url]

set :branch, 'master'

set :user, server_params[:deployment_user]
set :rvm_ruby_version, 'jruby-1.7.16.1'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:user)}/www"

# rubocop:disable Metrics/LineLength,
set :linked_files,
    %w{config/application.yml config/database.yml config/shards.yml config/secrets.yml}
# rubocop:enable Metrics/LineLength,

set :linked_dirs,
    %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 5

set :normalize_asset_timestamps,
    %w{public/images public/javascripts public/stylesheets}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), :in => :sequence, :wait => 5 do
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), :in => :groups, :limit => 3, :wait => 10 do
    end
  end
end
