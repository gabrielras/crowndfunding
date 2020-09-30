Rails.application.routes.draw do
  devise_for :clients, controllers: {
    registrations: 'clients/registrations',
    sessions: 'clients/sessions',
    passwords: 'clients/passwords'
  }

  namespace :client do
  end

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
