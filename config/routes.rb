Rails.application.routes.draw do

  root 'home#index'

  post '/submission', to: 'home#submission'

  get '/document/:id', to: 'home#view_doc', as: :document_view

  devise_for :users

end
