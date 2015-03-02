Rails.application.routes.draw do

  root :to => 'pages#landing'

  resources :users, :activities
  
  resources :bloodsugars, only: [:index, :create, :new] do
    collection { post :import }
  end

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  post '/whatever' => "foods#test"

  get '/testing' => 'pages#testing'

  resources :meals do
    resources :foods
  end

end
