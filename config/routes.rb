Rails.application.routes.draw do
  root :to => redirect("/users/sign_in")
  resources :comments
  resources :posts
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end


