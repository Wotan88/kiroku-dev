Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :users

  get '/posts', to: 'posts#index'
  get '/posts/new', to: 'posts#new'
  get '/posts/:id', to: 'posts#show'
  post '/posts', to: 'posts#create'
end
