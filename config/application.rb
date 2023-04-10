require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RCranIndexer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.api_only = true

    # Enables sessions https://guides.rubyonrails.org/api_app.html#using-session-middlewares
    # This also configures session_options for use below
    config.session_store :cookie_store, key: '_interslice_session'

    # Required for all session management (regardless of session_store)
  config.middleware.use ActionDispatch::Cookies

    config.middleware.use config.session_store, config.session_options

    config.active_job.queue_adapter = :sidekiq
  end
end
