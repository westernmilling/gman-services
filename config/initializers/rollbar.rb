Rollbar.configure do |config|
  config.access_token = Figaro.env.ROLLBAR_POST_SERVER_ITEM_ACCESS_TOKEN
  config.environment = Figaro.env.ROLLBAR_ENV || Rails.env
end
