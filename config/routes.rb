Rails.application.routes.draw do
  devise_for :clients, controllers: {
    registrations: 'clients/registrations',
    sessions: 'clients/sessions',
    passwords: 'clients/passwords'
  }

  namespace :client do
    resources :profiles, except: [:destroy]
    resources :projects
    resources :donations, only: [:index, :show, :new, :create]
  end

  resources :projects, only: [:index, :show]
  resources :clients, only: [:index]
  post :get_payment_status, to: 'get_payment_status#index', controller: 'get_payment_status'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
