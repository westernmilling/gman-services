lock '3.3.5'

set :application, Figaro.env.application
set :repo_url, Figaro.env.repo_url

set :branch, 'master'

set :user, Figaro.env.production_user
# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:user)}/www"

set :linked_files,
    %w{config/application.yml config/database.yml config/shards.yml}

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
