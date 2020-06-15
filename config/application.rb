# frozen_string_literal: true

require_relative 'boot'
require_relative '../lib/logging'
require 'rails/all'

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    logger = LogStashLogger.new(
      type: :udp,
      host: '0.0.0.0',
      port: 5000,
      sync: true,
      customize_event: ->(event) { Logging::EventTransformer::Server.call(event) }
    )

    config.logger = logger
    config.active_job.queue_adapter = :sidekiq
    config.log_tags = %i[uuid]
    config.colorize_logging = false

    HttpLog.configure do |config|
      config.enabled = true
      config.logger = logger
    end

    redis_config = { url: 'redis://127.0.0.1:6379/0', logger: config.logger }
    config.cache_store = :redis_cache_store, redis_config
  end
end
