Rails.application.routes.draw do
  devise_for :admins, path: :admin, only: [:sessions, :registrations], path_names: {
    sign_in: :login,
    sign_out: :logout,
    sign_up: :signup
  }, controllers: {
    sessions: "sessions",
    registrations: "registrations"
  }

  draw :api

  root to: "floors#index"
  resources :users
  resources :floors
  resources :contracts
end
