# frozen_string_literal: true

Sidekiq.configure_server do |_config|
  Rails.logger.formatter.instance_variable_set(
    '@customize_event',
    ->(event) { Logging::EventTransformer::Sidekiq.call(event) }
  )

  Sidekiq.logger = Rails.logger
end
