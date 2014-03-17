require "paypal/recurring"

PayPal::Recurring.configure do |config|
  config.sandbox = Rails.env.production? ? false : true
  config.username = AppConfig.username
  config.password = AppConfig.password
  config.signature = AppConfig.signature
end
