Rails.application.routes.draw do
  devise_for :users

  resources :patients

  # Nested namespace for doctors
  namespace :doctors do

     get 'dashboard', to: 'dashboard#index', as: 'dashboard_index' 

     get 'dashboard/patients/:id', to: 'dashboard#show', as: 'dashboard_patients'
    # resources :patients, only: [:index, :show]
    # Add more routes for doctors as needed

  end
  post 'switch_to_receptionist', to: 'dashboard#switch_to_receptionist'

   # Define custom route for doctor dashboard
  get 'doctors/dashboard', to: 'doctors#dashboard'


  # Route for switching roles
  post 'users/switch_role', to: 'users#switch_role', as: 'switch_role'

  # Defines the root path route ("/")
  root "patients#index"
end
