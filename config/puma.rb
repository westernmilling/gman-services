# workers Integer(ENV['WEB_CONCURRENCY'] || 2)
root = File.expand_path('../../', __FILE__)
threads_count = Integer(ENV['MAX_THREADS'] || 11)
threads threads_count, threads_count

preload_app!

daemonize
rackup DefaultRackup
pidfile "#{root}/tmp/pids/puma.pid"
port ENV['PORT'] || 3000
environment ENV['RAILS_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
