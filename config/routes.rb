Rails.application.routes.draw do
  resources :vinyls

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'store#index', as: 'store'
end
