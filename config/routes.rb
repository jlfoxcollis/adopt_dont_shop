Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"

  resources :shelters, as: 'shelters' do
    resources :pets, controller: "shelter_pets", only: [:index, :new, :create]
  end

  resources :pets, as: 'pets'
  resources :applications, as: 'applications'
  resources :application_pets, as: 'application_pets'

  namespace :admin do
    resources :applications
    resources :application_pets
    resources :shelters
  end

  get '/admin', to: "admin#index", as: 'admin'
end
