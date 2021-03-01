Rails.application.routes.draw do
  root to: "floors#index", locale: I18n.default_locale

  scope "(/:locale)" do
    devise_for :admins, path: :admin, only: [:sessions, :registrations], path_names: {
      sign_in: :login,
      sign_out: :logout,
      sign_up: :signup
    }, controllers: {
      sessions: "sessions",
      registrations: "registrations"
    }

    draw :api
    resources :users
    resources :floors
    resources :contracts
    resources :invoices, only: [:index, :new, :create, :show]

    namespace :batch_create do
      resources :users, only: :create
      resources :invoices, only: [:new, :create]
    end
  end
end
