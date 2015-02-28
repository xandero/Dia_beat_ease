Rails.application.routes.draw do

  root :to => 'users#index'
  resources :users, :foods, :activities, :bloodsugars

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

end
