namespace :api, defaults: { format: :json } do
  resources :users, only: [:index]
  resources :rooms, only: [:update]
  namespace :users, defaults: { format: :json } do
    resources :rooms, only: [:index]
  end
end
