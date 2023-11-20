Rails.application.routes.draw do
  devise_for :users
  root 'rooms#index'

  resources :rooms, only: %i[index show create destroy], param: :token

  mount ActionCable.server => '/cable'
end
