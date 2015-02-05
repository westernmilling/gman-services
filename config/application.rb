# require 'config/initializers/monkey_magic'
jar_path = File.expand_path('../../lib/RelJDBC.jar', __FILE__)
# puts jar_path
$CLASSPATH << jar_path

require File.expand_path('../boot', __FILE__)

require 'rails/all'
java.lang.Class.for_name('javax.crypto.JceSecurity')
  .get_declared_field('isRestricted')
  .tap do |f|
  f.accessible = true
  f.set nil, false
end

require 'csv'
require File.expand_path('../boot', __FILE__)

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GmanServices
  class Application < Rails::Application
    # Settings in config/environments/*
    # take precedence over those specified here.
    # Application configuration should go into
    # files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make
    # Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    # Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from
    # config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path +=
    #   Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # create a db specific dump in structure.sql file rather than schema.rb.
    # IIRC when :sql is set rails test code loads that instead of the schema.rb
    config.active_record.schema_format = :sql
  end
end
