# frozen_string_literal: true

class PostPublishingJob < ApplicationJob
  def perform(post_id)
    Post.find(post_id).update!(published: true)
    Rails.cache.clear
  end
end
