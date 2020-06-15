# frozen_string_literal: true

class Api::PostsController < ActionController::API
  before_action :find_post, only: %i[edit update destroy publish]
  after_action :clear_cache, only: %i[update destroy]

  def index
    page = (params[:page] || 1).to_i - 1
    posts = Rails.cache.fetch("posts:#{page}") do
      Post.limit(20).offset(20 * page).where(published: true).as_json
    end

    render json: posts
  end

  def create
    @post = Post.create!(post_params)

    render json: @post
  end

  def show
    render json: @post
  end

  def update
    @post.update!(post_params)

    render json: @post
  end

  def destroy
    @post.destroy!

    head :ok
  end

  def publish
    PostPublishingJob.perform_later(@post.id)

    head :ok
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def clear_cache
    Rails.cache.clear
  end

  def post_params
    params.permit(:title, :content)
  end
end
