Rails.application.routes.draw do
  
  devise_for :users, :controllers => { registrations: 'registrations'}
    match 'users/:id' => 'users#destroy', :via => :delete, :as => :destroy_user
    
    resources :users, :only => [:show,:new]


    #root page
  get "/home" => "pages#home"
  root "pages#home"

#add user
  get "/addUser" => "pages#add"
  ####get "/users/new" => "users#new", as: :new_user
  post 'create_user' => 'users#create', as: :create_user      


end
