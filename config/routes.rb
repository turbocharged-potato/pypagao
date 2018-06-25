# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html

  post '/authentication/login', to: 'authentication#login'
  post '/authentication/register', to: 'authentication#register'
  get '/authentication/verify', to: 'authentication#verify'
  get '/authentication/check', to: 'authentication#check'
end
