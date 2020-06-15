# frozen_string_literal: true

class Logging::EventTransformer::Sidekiq < Logging::EventTransformer
  def self.call(event)
    super

    event[:service] = 'sidekiq'
    Thread.current[:sidekiq_context]&.each { |k, v| event[k] = v }
  end
end
