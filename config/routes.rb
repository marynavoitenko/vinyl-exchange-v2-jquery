Rails.application.routes.draw do

  get '/vinyls/my_vinyls', to: 'vinyls#my_vinyls', as: 'my_vinyls'

  resources :vinyls

  resources :artists, only: [:show] do
    resources :vinyls, only: [:show, :index, :new]
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'store#index', as: 'store'

  resources :line_items, only: [:create, :edit, :update]
  resources :carts, only: [:show, :edit]

end
