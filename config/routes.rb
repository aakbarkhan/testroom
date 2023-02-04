Rails.application.routes.draw do
  # get 'staticpages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  root "staticpages#home"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # get 'auth/:provider/callback', to: 'sessions#omniauth'
  
end
