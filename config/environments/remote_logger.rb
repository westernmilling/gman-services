Rails.application.configure do
  config.logger = if Figaro.env.REMOTE_LOG_HOST.present? &&
                     Figaro.env.REMOTE_LOG_PORT.present?
                    RemoteSyslogLogger.new(
                      Figaro.env.REMOTE_LOG_HOST,
                      Figaro.env.REMOTE_LOG_PORT,
                      program: "gman-services-#{Rails.env}"
                    )
                  else
                    Logger.new(STDOUT)
                  end

  config.log_formatter = ::Logger::Formatter.new
  config.log_level = (Figaro.env.REMOTE_LOG_LEVEL || 'info').to_sym
end
