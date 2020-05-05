Rails.application.routes.draw do
  #shelters
  get '/shelters/new', to: 'shelters#new'
  get '/shelters', to: 'shelters#index'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'
end
