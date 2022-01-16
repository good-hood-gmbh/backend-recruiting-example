Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  concern :complainable do |options|
    resource :complains, complainable_config: options
  end

  resource :complains
  resource :no_votes

  concern :thankable do |options|
    resources :thankyous, thankable_config: options
  end

  resource :thankyous

  concern :profile_messagable do |options|
    resources :profile_messages, controller: 'profile_messages', profile_messagable_config: options do
      concerns :thankable, options
      concerns :complainable, options
    end
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :business_profiles do
    concerns :profile_messagable, { profile_type: :organization_profile,
                                    thankable:    :organization_profile_message, thankable_key: :profile_message_id,
                                    complainable: :organization_profile_message }
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
