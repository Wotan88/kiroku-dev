Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :users

  get '/i/:id', to: 'posts#serve', constraints: { id: /[a-f\-0-9]+(.jpeg|.jpg|.png)/ }
  resources :posts
end
