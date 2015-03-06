Rails.application.routes.draw do

  root :to => 'pages#index'

  # get '/index' => 'pages#index'
  # OPEN SINGLE CALC PAGE
  get '/singlecalculation' => 'pages#calc'
  get '/weather' => 'pages#weather'  

  resources :users, :activities

  resources :meals do
    resources :foods
  end

  resources :bloodsugars, only: [:index] do
    collection { post :import }
  end

  # JSON ROUTES
  get '/dashboard' => 'users#dashboard'

  # BLOODSUGAR DATA JSON PAGE
  get '/readingdata' => 'bloodsugars#data'
  get '/readingdata/bslevel' => 'users#bslevel'
  get '/readingdata' => 'bloodsugars#data'
  get '/readingdata/readingtime' => 'users#readingtime'
  get '/readingdata/bslevel_lastthirty' => 'users#bslevel_lastthirty'
  get '/readingdata/readingtime_lastthirty' => 'users#readingtime_lastthirty'
  # MEAL DATA JSON PAGE
  get '/readingdata/foods' => 'foods#index'
  get '/readingdata/carbs' => 'foods#carbs'
  get '/readingdata/mealtime' => 'foods#mealtime'
  get '/readingdata/carbs_lastthirty' => 'foods#carbs_lastthirty'
  get '/readingdata/mealtime_lastthirty' => 'foods#mealtime_lastthirty'
  # ACTIVITY DATA JSON PAGE
  get '/readingdata/duration' => 'activities#duration'
  get '/readingdata/activity_time' => 'activities#activity_time'
  get '/readingdata/duration_lastthirty' => 'activities#duration_lastthirty'
  get '/readingdata/activity_time_lastthirty' => 'activities#activity_time_lastthirty'

  # SESSION LOGIN PAGE
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'


end
