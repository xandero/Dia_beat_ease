Rails.application.routes.draw do

  root :to => 'users#index'
  resources :users, :foods, :activities, :bloodsugars

end
