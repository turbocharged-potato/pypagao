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

  resources :universities
  resources :courses
  resources :semesters

  resources :answers
  resources :questions

  resources :papers
  resources :votes
  resources :comments
end
