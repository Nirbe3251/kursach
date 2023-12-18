Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :users
  root 'rooms#index'
  
  post '/rooms/:token/edit', to: 'rooms#edit', as: 'edit_room'
  post '/rooms/:token/leave_room', to: 'rooms#leave_room', as: 'leave_room'

  resources :rooms, only: %i[index show create destroy leave_room], param: :token do
    member do
      get :check_password
      get :user_ban
      get :add_user
    end
  end
  get 'user/:id', to: 'users#index', as: 'user'
end
