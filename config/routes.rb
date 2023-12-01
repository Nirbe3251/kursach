Rails.application.routes.draw do
  devise_for :users
  root 'rooms#index'
  
  resources :rooms, only: %i[index show create destroy], param: :token do
    member do
      get :check_password
    end
  end
  get 'users/:id', to: 'users#index'


  mount ActionCable.server => '/cable'
end
