# frozen_string_literal: true

class Logging::EventTransformer
  def self.call(event)
    event[:env] = Rails.env
  end
end
