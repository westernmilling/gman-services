lock '3.4.0'

set :repo_url, 'git@github.com:westernmilling/gman-services.git'
set :branch, 'master'
set :user, 'deploy'
set :deploy_to, '/var/www'
set :linked_files, %w{
  config/application.yml
  config/database.yml
  lib/RelJDBC.jar
}
set :linked_dirs,
    %w{og tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :keep_releases, 5
set :normalize_asset_timestamps,
    %w{public/images public/javascripts public/stylesheets}
set :rvm_type, :user
set :rvm_ruby_version, 'jruby-9.0.5.0'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
    end
  end

  after :publishing, :restart
  after :publishing, 'deploy:assets:precompile'
end
