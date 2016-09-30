Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.raise_runtime_errors = true
  config.action_view.raise_on_missing_translations = true

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new
  config.logger = RemoteSyslogLogger.new(Figaro.env.REMOTE_LOG_HOST,
                                         Figaro.env.REMOTE_LOG_PORT)
  config.logger.level = Logger.const_get('INFO')
  config.log_level = (Figaro.env.REMOTE_LOG_LEVEL || 'info').to_sym
end
