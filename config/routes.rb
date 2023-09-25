Rails.application.routes.draw do
  root :to => redirect("/users/sign_in")

  resources :posts
  resources :comments


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end


