namespace :api, defaults: { format: :json } do
  resources :users, only: [:index]
  resources :rooms, only: [:update]
end
