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

  resources :universities, except: %i[update destroy]

  # For user login
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, except: %i[update destroy]

  resources :universities, only: %i[create index]
  resources :courses, only: %i[create index]
  resources :semesters, only: %i[create index]

  resources :answers, only: %i[create index]
  resources :questions, only: %i[create index]

  resources :papers, only: %i[create index]
  resources :votes, only: %i[create index]
  resources :comments, only: %i[create index]
end
