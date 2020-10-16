Rails.application.routes.draw do
  devise_for :users, path: :user, only: [:sessions, :registrations], path_names: {
    sign_in: :login,
    sign_out: :logout,
    sign_up: :signup
  }, controllers: {
    sessions: "sessions",
    registrations: "registrations"
  }

  draw :api

  root to: "home_pages#index"
  resources :users
end
