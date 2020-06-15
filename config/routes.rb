# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :posts, except: :edit do
      post :publish, on: :member
    end

    resources :external_services, only: %i[index show]
  end
end
