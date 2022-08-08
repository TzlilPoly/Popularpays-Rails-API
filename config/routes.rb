Rails.application.routes.draw do
  # get '/404', to: 'errors#not_found'
  # get '/500', to: 'errors#internal_server_error'
  resources :creators
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :gigs
  resources :gig_payments
end
