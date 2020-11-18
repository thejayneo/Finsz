Rails.application.routes.draw do
  resources :orders
  resources :products
  devise_for :users
  root 'home#index'
  get "/payments/success", to: "payments#success"
  post "/payments/webhook", to: "payments#webhook"

  # get '*path', to: redirect('/'), constraints: lambda { |req|
  #   req.path.exclude? 'rails/active_storage'
  # }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '/user' => "products#index", :as => :user_root

end
