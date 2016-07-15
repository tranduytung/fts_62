Rails.application.routes.draw do

  get "home" => "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"

  root "static_pages#home"

  devise_for :admins, controllers: {
    sessions: "admins/sessions"
  }, skip: [ :passwords, :registrations]
  devise_scope :admin do
    get "admins/edit" => "admins/registrations#edit",
      as: "edit_admin_registration"
    put "admins" => "admins/registrations#update", as: "admin_registration"
  end

  namespace :admins do
    resources :subjects
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }, skip: :passwords

end
