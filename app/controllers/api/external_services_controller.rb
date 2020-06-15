# frozen_string_literal: true

class Api::ExternalServicesController < ActionController::API
  def index
    response = Faraday.get('https://jsonplaceholder.typicode.com/posts')

    render json: JSON.parse(response.body)
  end

  def show
    response = Faraday.get("https://jsonplaceholder.typicode.com/posts/#{params[:id]}")

    render json: JSON.parse(response.body)
  end
end
