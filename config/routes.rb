Rails.application.routes.draw do

  root :to => 'pages#landing'
  resources :users, :foods, :activities

  resources :bloodsugars, only: [:index, :create, :new] do
    collection { post :import }
  end

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  get '/testing' => 'pages#testing'

  resources :meals do
    resources :foods
  end

end
