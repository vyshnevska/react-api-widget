Rails.application.routes.draw do
  devise_for :users
  resources :posts
  namespace :api do
    namespace :v1 do
      resources :messages
    end
  end
  root to: 'posts#index'
end
