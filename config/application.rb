require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Yosis
  class Application < Rails::Application
    VERSION = '0.3.1'.freeze

    VIDEO_PREVIEW_SIZE=    [320, 180].freeze
    HEADER_IMAGE_SIZE=     [1024,287].freeze
    STYLE_CARD_IMAGE_SIZE= [354, 200].freeze
    IMAGE_128x128=         [128, 128].freeze

    config.time_zone = "Berlin"
    config.active_record.default_timezone = :local

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.i18n.available_locales = [:de, :en]
    config.i18n.default_locale = :de

    config.active_job.queue_adapter     = :delayed_job
  end
end
