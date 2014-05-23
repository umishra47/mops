LoginApp::Application.routes.draw do

  resources :subscriptions

  get "authentication/index"
  get "authentication/create"
  get "authentication/destroy"
  resources :servers, controller: "products"
  namespace :admin do
    resources :images
  end

  devise_for :users, controllers: {sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords", confirmations: 'users/confirmations' }
  devise_scope :user do
    match 'login', to: "users/sessions#new", via: [:get, :post], as: "login"
    get "logout", to: "devise/sessions#destroy", as: "logout"
    match '/add_mail' => 'users/registrations#add_mail', via: [:get, :post]
    get '/auth/failure' => "users/sessions#new"
    get 'return' => "users/sessions#new"
  end
  root 'welcome#landing'
  match '/auth/:provider/callback' => 'authentication#create', via: [:get, :post]
  get "/launch_server" => "products#new", as: :launch_server
  get "/transaction_completed" => "products#show"
  match "/transaction_payment" => "products#transaction_details", via: [:get, :post]
  get '/pricing' => "welcome#pricing"
  get '/faq' => "static_pages#tos"
  get "/404", to: "errors#not_found"
  get "/500", to: "errors#error"
end
