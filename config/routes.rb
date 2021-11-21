Rails.application.routes.draw do
  
  namespace :admin do
    root 'dashboard#index'
    get 'styles', to: 'dashboard#styles', as: 'styles'
    resources :users
    # resources :roles
  end
  root 'home#index'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
