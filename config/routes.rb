Rails.application.routes.draw do

  root :to => 'pages#landing'
  resources :users, :activities, :bloodsugars

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  post '/whatever' => "foods#test"

  get '/testing' => 'pages#testing'

  resources :meals do
    resources :foods
  end

end
