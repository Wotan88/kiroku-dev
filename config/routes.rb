Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :users

  resources :posts do
    get '/attachment', to: 'posts#serve', on: :member
  end
end
