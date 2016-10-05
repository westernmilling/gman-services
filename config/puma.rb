ENV['PORT'] ||= '3000'
ENV['RAILS_ENV'] ||= 'development'

# NB: Since there are issues running puma under jruby with init.d we should
#     change this to not be daemonized and use something like monit or god
#     to keep it running.
# http://codetunes.com/2015/deployment-setup-for-jruby-rails-app-with-puma-mina-and-monit/
threads_count = Integer(ENV['MAX_THREADS'] || 11)
threads threads_count, threads_count

preload_app!

rackup DefaultRackup

if %w{production staging}.include?(ENV['RAILS_ENV'])
  root = File.expand_path('../../', __FILE__)
  daemonize
  pidfile "#{root}/tmp/pids/puma.pid"
end

port ENV['PORT']
environment ENV['RAILS_ENV']

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
