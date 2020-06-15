# frozen_string_literal: true

class Logging::EventTransformer::Server < Logging::EventTransformer
  def self.call(event)
    super

    event[:service] = 'server'
  end
end
