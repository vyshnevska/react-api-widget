Rails.application.routes.draw do
  resources :posts
  namespace :api do
    namespace :v1 do
      resources :messages
    end
  end
  root to: 'posts#index'
end
