Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"

  get "/admin/applications", to: "applications#admin_index"
  get "/admin/applications/:id", to: "applications#admin_show"

  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  get "/shelters/:id", to: "shelters#show"
  delete "/shelters/:id", to: "shelters#destroy"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"

  get '/applications/new', to: 'applications#new'
  get '/applications/:id', to: 'applications#show'
  # post '/applications/:id', to: 'applications#create'
  post '/applications', to: 'applications#create'
  patch '/applications/:id', to: 'applications#show'
  # patch '/applications/:id', to: 'applications#p_c_update'

  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"

  get "/shelters/:shelter_id/pets", to: "shelter_pets#index"
  get "/shelters/:shelter_id/pets/new", to: "shelter_pets#new"
  post "/shelters/:shelter_id/pets", to: "shelter_pets#create"
  get "/shelters/:id/pets/:id", to: "pets#show"
end
