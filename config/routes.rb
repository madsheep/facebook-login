SociaLoginRails::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  get "pages/terms"
  get "pages/welcome"
  get "pages/landing"
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'pages#landing'
  ActiveAdmin.routes(self)

end
