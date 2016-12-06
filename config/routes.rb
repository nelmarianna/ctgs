Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations'}
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :destroy_user

  resources :users, :only => [:show,:new]

  #root page
  get "/home" => "pages#home"
  root "pages#home"

  #add user
  get "/addUser" => "pages#add"
  post 'create_user' => 'users#create', as: :create_user

  #application
  resources :applications, param: :application_id, :except => [:edit, :destroy]
  get"/applications/:application_id/edit" => "applications#edit", :as => :application_edit
  # patch "/applications/:application_id/edit" => "applications#update"

end
