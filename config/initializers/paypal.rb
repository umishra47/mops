require "paypal/recurring"

PayPal::Recurring.configure do |config|
  config.sandbox = true
  config.username = AppConfig.username
  config.password = AppConfig.password
  config.signature = AppConfig.signature
end
