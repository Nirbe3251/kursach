Rails.application.routes.draw do
  devise_for :users
  root 'rooms#index'

  resources :rooms, only: %i[index show create destroy], param: :token
  get 'users/:id', to: 'users#index'

  mount ActionCable.server => '/cable'
end
