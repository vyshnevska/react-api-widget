Rails.application.routes.draw do
  resources :posts do
    member do
      post :add_comment
      post :update_comment
    end
  end

  devise_for :users, controllers: { sessions: 'custom_sessions' }

  as :user do
    post   "/sign-in"  => "sessions#create"
    delete "/sign-out" => "sessions#destroy"
  end

  namespace :api do #, path: '/', constraints: { subdomain: 'api' } do
    namespace :v1, defaults: { format: :json } do
      resources :messages, only: [:create, :update, :index]

      resources :subscriptions, only: [:index, :create] do
        collection do
          post :create_channel
          get :channels
        end
      end

      as :user do
        post   "/sign-in"  => "sessions#create"
        delete "/sign-out" => "sessions#destroy"
      end
    end
  end

  root to: 'posts#index'

  slugs = %w|root|
  resource :posts, only: [:show], constraints: {id: Regexp.new(slugs.join('|'))}
end
