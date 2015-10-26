Rails.application.routes.draw do

  root 'home#index'

  post '/submission', to: 'home#submission'

  devise_for :users

end
