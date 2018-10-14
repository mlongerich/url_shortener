# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'links#index'

  resources :links, except: %i[index create update show]

  post '/add', to: 'links#create'

  get '/links', to: 'links#links'
  get '/:id', to: 'links#show'
end
