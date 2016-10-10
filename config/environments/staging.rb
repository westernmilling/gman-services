require_relative 'remote_logger'

Rails.application.configure do
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.raise_runtime_errors = true
  config.action_view.raise_on_missing_translations = true
  config.cache_classes = false
  config.consider_all_requests_local = true
  config.eager_load = false
end
