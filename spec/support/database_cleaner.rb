RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    grossman_connection_cleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
    grossman_connection_cleaner.strategy = :truncation
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
    grossman_connection_cleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
    grossman_connection_cleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    grossman_connection_cleaner.clean
  end

  def grossman_connection_cleaner
    DatabaseCleaner[
      :active_record,
      { connection: "grossman_#{Rails.env}".to_sym }
    ]
  end
end
