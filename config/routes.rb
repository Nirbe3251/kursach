Rails.application.routes.draw do
  root 'rooms#index'

  resources :rooms, only: %i[index show create], param: :token

  mount ActionCable.server => '/cable'
end
