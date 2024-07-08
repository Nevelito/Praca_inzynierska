# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PracaInzynierska
  class Application < Rails::Application
    config.load_defaults 7.0
    config.i18n.default_locale = :pl
    config.time_zone = 'Europe/Warsaw'
  end
end
