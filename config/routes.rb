Rails.application.routes.draw do
  resources :events do
    resources :tickets, only [:index, :create] # Nested route for event-tickets
  end
  
  resources :tickets, except: [:index, :create]  # Standalone tickets route for the rest of the CRUD
  resources :clients
end
