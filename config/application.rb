require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UnofficalWebhooks
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    
    # ActiveJob Queueing backend
    config.active_job.queue_adapter = :sidekiq

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
            headers: :any,
            expose: %w[authorization access-token expiry
                      token-type uid client],
            methods: %i[get post options delete put]
      end
    end
    
    # ActiveRecord Schema Format
    config.active_record.schema_format = :sql
    
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
