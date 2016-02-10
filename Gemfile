source 'https://rubygems.org'
ruby '1.9.3', engine: 'jruby', engine_version: '1.7.19'

gem 'activerecord-jdbc-adapter'
gem 'activerecord-relativity-adapter',
    github: 'josephbridgwaterrowe/activerecord-relativity-adapter'
gem 'activerecord-jdbcmysql-adapter'
gem 'awesome_print'
gem 'devise'
gem 'doorkeeper', '2.2.1'
gem 'figaro'
gem 'jdbc-mysql', platform: :jruby
gem 'jquery-rails'
gem 'jruby-openssl'
gem 'mysql2', platform: :ruby
gem 'net-ssh', '2.9.2'
gem 'omniauth'
gem 'omniauth-oauth2', '1.0.3'
gem 'plissken', git: 'https://github.com/michaelachrisco/plissken.git',
                branch: 'trailing_spaces'
gem 'puma'
gem 'rails', '4.1.5'
gem 'ransack', '1.6.5'
gem 'seedbank'
gem 'squeel', '1.2.3'
gem 'symbolize'
gem 'turbolinks'
gem 'therubyrhino'
gem 'uglifier', '>= 1.0.3'

group :development, :test do
  gem 'capistrano', '3.4.0'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'foreman'
  gem 'hound-tools', '~> 0.0.6',
      github: 'michaelachrisco/hound-tools',
      require: false
  gem 'rubocop', '0.28.0', require: false
end

group :test do
  gem 'capybara'
  gem 'coveralls', require: false
  gem 'json_spec'
  gem 'rspec-its'
  gem 'rspec-rails', '~> 3.0'
end
