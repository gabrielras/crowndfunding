Rails.application.routes.draw do
  devise_for :clients, controllers: {
    registrations: 'clients/registrations',
    sessions: 'clients/sessions',
    passwords: 'clients/passwords'
  }

  namespace :client do
    resources :profiles, except: [:destroy]
    resources :projects
    resources :donations, only: [:index, :show]
  end

  resources :projects, only: [:index, :show]
  resources :donations, only: [:new]
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
