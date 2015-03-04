Rails.application.routes.draw do

  root :to => 'pages#landing'
  get '/uhoh' => 'pages#redirect'

  resources :users, :activities

  resources :bloodsugars, only: [:index] do
    collection { post :import }
  end

  get '/dashboard' => 'users#dashboard'
  get '/readingdata' => 'bloodsugars#data'
  get '/readingdata/bslevel' => 'users#bslevel'
  get '/readingdata/readingtime' => 'users#readingtime'

  get '/readingdata/bslevel_lastthirty' => 'users#bslevel_lastthirty'
  get '/readingdata/readingtime_lastthirty' => 'users#readingtime_lastthirty'


  get '/readingdata/foods' => 'foods#index'

  get '/readingdata/carbs' => 'foods#carbs'
  get '/readingdata/mealtime' => 'foods#mealtime'

  get '/readingdata/carbs_lastthirty' => 'foods#carbs_lastthirty'
  get '/readingdata/mealtime_lastthirty' => 'foods#mealtime_lastthirty'



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
