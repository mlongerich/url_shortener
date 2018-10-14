# frozen_string_literal: true

Rails.application.routes.draw do
  resources :links, except: %i[create update show]
  post '/add', to: 'links#create'
  get '/:id', to: 'links#show'
end
