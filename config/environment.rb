# Load the Rails application.
require_relative "application"

envconfig = File.join(Rails.root, 'config', 'db.rb')
load(envconfig) if File.exist?(envconfig)

# Initialize the Rails application.
Rails.application.initialize!
