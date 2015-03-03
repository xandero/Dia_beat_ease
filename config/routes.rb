Rails.application.routes.draw do

  root :to => 'pages#landing'

  resources :users, :activities

  resources :bloodsugars, only: [:index] do
    collection { post :import }
  end

  get '/readingdata' => 'bloodsugars#data'

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  post '/whatever' => "foods#test"

  get '/singlecalculation' => 'pages#calc'

  get '/testing' => 'pages#testing'

  resources :meals do
    resources :foods
  end

end
