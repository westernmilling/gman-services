# config valid only for current version of Capistrano
lock '3.4.0'

set :application, ''
set :repo_url, 'git@github.com:westernmilling/gman-services.git'

set :branch, 'master'

set :user, 'deploy'
set :deploy_to, '/var/www/gman_services'

set :rvm_type, :user
set :rvm_ruby_version, 'jruby-1.7.19'

set :linked_files, %w{
  config/application.yml
  config/database.yml
  config/shards.yml
  config/secrets.yml
  lib/RelJDBC.jar
}

set :linked_dirs,
    %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system lib}

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
  after :publishing, 'deploy:assets:precompile'

  web_servers = %w{}

  namespace :assets do
    task :precompile do
      run_locally do
        execute 'RAILS_ENV=production',
                :bundle, :exec, :rake, 'assets:precompile'
      end

      web_servers.each do |web_server|
        Rails.logger.info "Deploying to web server: #{web_server}"

        run_locally do
          execute :ssh, "www@#{web_server}", "mkdir -p #{release_path}"
          execute :rsync, "-av ./public www@#{web_server}:#{release_path}"
          # execute :ssh, "www@#{web_server}", "rm -f #{deploy_to}/current"
          # execute :ssh, "www@#{web_server}", "ln -s #{release_path} #{deploy_to}/current"
        end
      end

      run_locally { execute :rm, '-rf public/assets' }
    end
  end
end
