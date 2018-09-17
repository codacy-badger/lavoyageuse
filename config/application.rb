require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Lavoyageuse
  class Application < Rails::Application
    config.action_mailer.default_url_options = { host: 'https://www.parentheze.com' }

    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework  :test_unit, fixture: false
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.i18n.default_locale = :fr

    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = { api_token: 'd3c8ea66-197f-4a14-9cb1-807477a3bd20' }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
