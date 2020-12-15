Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"

  namespace :admin do
    get '/dashboard', to: "dashboard#index"
  end

  resources :shelters, as: 'shelters'
  resources :pets, as: 'pets'
  namespace :admin do
    resources :applications
    resources :application_pets
    resources :shelters
  end
  resources :applications, as: 'applications'

    get "/shelters/:shelter_id/pets", to: "shelter_pets#index", as: 'shelter_pets'
    get "/shelters/:shelter_id/pets/new", to: "shelter_pets#new", as: 'new_shelter_pet'
    post "/shelters/:shelter_id/pets", to: "shelter_pets#create", as: 'create_shelter_pet'
    get "/shelters/:id/pets/:id", to: "pets#show", as: 'show_pet'



  get '/admin', to: "admin#index", as: 'admin'
  # get '/admin/applications', to: "admin_applications#index", as: 'admin_apps'
  # get '/admin/applications/:id', to: "admin_applications#show", as: 'admin_app'
  # patch '/admin/applications/:id', to: "admin_applications#update", as: 'update_admin_app'

end
