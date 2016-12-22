Rails.application.routes.draw do
  root 'static_pages#home'

  devise_for :users

  get '/i/:id', to: 'posts#serve', constraints: { id: /[a-f\-0-9]+(.jpeg|.jpg|.png)/ }
  resources :posts

  get '/api/complete.json', to: 'json_api#complete'

  get '/search', to: 'search#by_tags'
end
