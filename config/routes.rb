Rails.application.routes.draw do
  resources :posts
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :messages
      as :user do
        post   "/sign-in"  => "sessions#create"
        delete "/sign-out" => "sessions#destroy"
      end
    end
  end
  root to: 'posts#index'
end
