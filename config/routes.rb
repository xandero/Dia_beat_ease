Rails.application.routes.draw do

  root :to => 'pages#landing'

  resources :users, :activities

  resources :bloodsugars, only: [:index] do
    collection { post :import }
  end

  get '/dashboard' => 'users#dashboard'
  get '/readingdata' => 'bloodsugars#data'
  get '/readingdata/bslevel' => 'users#bslevel'
  get '/readingdata/readingtime' => 'users#readingtime'


  # get '/readingcharts' => 'bloodsugars#charts'
  # get '/weather' => 'bloodsugars#weather'

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
