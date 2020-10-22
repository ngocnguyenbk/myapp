namespace :api, defaults: { format: :json } do
  resources :users, only: [:index]
end
