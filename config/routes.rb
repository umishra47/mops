LoginApp::Application.routes.draw do

  get "authentication/index"
  get "authentication/create"
  get "authentication/destroy"
  resources :instances


  devise_for :users, controllers: {sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords"}
  devise_scope :user do
    get 'registration', to: "users/registrations#auth"
    get "logout", to: "devise/sessions#destroy", as: "logout"
    match '/add_mail' => 'users/registrations#add_mail', via: [:get, :post]
    get '/auth/failure' => "users/registrations#auth"
  end
  root 'welcome#index'
  match '/auth/:provider/callback' => 'authentication#create', via: [:get, :post]
  get "/launch_instance" => "instances#new", as: :launch_instance

  resources :instance_types
end
