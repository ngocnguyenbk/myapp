namespace :api, defaults: { format: :json } do
  namespace :floors, defaults: { format: :json } do
    resources :users, only: [:index]
    resources :rooms, only: [:update]
  end

  namespace :users, defaults: { format: :json } do
    resources :rooms, only: [:index]
  end

  namespace :contracts, defaults: { format: :json } do
    resources :rooms, only: [:index]
    resources :users, only: [:index]
  end

  namespace :invoices, defaults: { format: :json } do
    resources :rooms, only: [:index]
  end
end
