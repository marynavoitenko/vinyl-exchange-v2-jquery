Rails.application.routes.draw do
  resources :vinyls

  resources :artists, only: [:show] do
    resources :vinyls, only: [:show, :index]
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'store#index', as: 'store'
end
