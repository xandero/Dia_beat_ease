Rails.application.routes.draw do

  root :to => 'pages#landing'
  resources :users, :foods, :activities, :bloodsugars

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

end
