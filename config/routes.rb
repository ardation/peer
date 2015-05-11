Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  namespace :api do
    api_version module: 'V1', path: { value: 'v1' }, default: true do
      resources :conversations, except: [:update] do
        resources :messages
        resources :participants
      end
      resources :friends do
        collection do
          get 'fetch'
        end
      end
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
    end
  end
end
