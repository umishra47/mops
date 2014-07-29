# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
LoginApp::Application.initialize!

ENV['DB_USERNAME'] = "postgres"
ENV['DB_PASSWORD'] = "pd"
