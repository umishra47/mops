LoginApp::Application.routes.draw do

  resources :subscriptions

  get "authentication/index"
  get "authentication/create"
  get "authentication/destroy"
  resources :instances


  devise_for :users, controllers: {sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords"}
  devise_scope :user do
    match 'regist', to: "users/registrations#auth", via: [:get, :post]
    get "logout", to: "devise/sessions#destroy", as: "logout"
    match '/add_mail' => 'users/registrations#add_mail', via: [:get, :post]
    get '/auth/failure' => "users/registrations#auth"
    get 'return' => "users/registrations#auth"
  end
  root 'welcome#index'
  match '/auth/:provider/callback' => 'authentication#create', via: [:get, :post]
  get "/launch_instance" => "instances#new", as: :launch_instance
  get "/transaction_completed" => "instances#show"
  match "/transaction_payment" => "instances#transaction_details", via: [:get, :post]

  resources :instance_types
end
