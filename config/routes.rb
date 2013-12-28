LoginApp::Application.routes.draw do

  resources :instances

  root 'welcome#index'

  devise_for :users, controllers: {sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords"}
  devise_scope :user do
   get "logout", to: "devise/sessions#destroy", as: "logout"
  end

  get "/auth/:provider/callback" => "sessions#create"
  get "/users/sign_out" => "sessions#destroy", :as => :signout
  get "/google/auth" => "sessions#create"
  get "/launch_instance" => "instances#new", as: :launch_instance

  resources :instance_types
end
