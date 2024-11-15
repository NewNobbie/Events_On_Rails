Rails.application.routes.draw do
  devise_for :clients

  resources :events do
    resources :tickets, only: [:index, :create] # Nested route for event-tickets
  end
  
  resources :tickets, except: [:index, :create]  # Standalone tickets route for the rest of the CRUD

  root "events#index"
end
