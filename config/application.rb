require_relative 'boot'

require 'rails/all'
require 'sprockets/rails/task'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Crowdfunding
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.middleware.delete Rack::Runtime
    config.load_defaults 6.0
    config.encoding = 'UTF-8'
    config.active_job.queue_adapter = :sidekiq
    config.i18n.default_locale = :'pt-BR'

    config.serve_static_files = true
    config.time_zone = 'America/Fortaleza'

    config.autoload_paths << "#{config.root}/app/workers"
    config.autoload_paths << "#{config.root}/app/services"
    config.autoload_paths << "#{config.root}/app/services/concerns"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
