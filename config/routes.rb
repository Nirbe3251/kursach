Rails.application.routes.draw do
  devise_for :users
  root 'rooms#index'
  
  resources :rooms, only: %i[index show create destroy], param: :token do
    member do
      get :check_password
      get :user_ban
      get :add_user
    end
  end
  get 'user/:id', to: 'users#index', as: 'user'


  mount ActionCable.server => '/cable'
end
