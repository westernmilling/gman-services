require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/puma'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/rvm'
require 'rollbar/capistrano3'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
