require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestGuru
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.time_zone = 'Moscow'
    config.encoding = 'utf-8'
    config.action_dispatch.default_charset = 'utf-8'

    config.action_view.sanitized_allowed_tags = %w[
      strong em b i p code pre tt samp kbd var sub sup dfn cite big small address r br div span
      h1 h2 h3 h4 h5 h6 ul ol li dl dt dd abbr acronym a img blockquote del ins
    ]

    config.action_view.sanitized_allowed_attributes = %w[href src width height alt cite datetime title class name xml:lang abbr target]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
