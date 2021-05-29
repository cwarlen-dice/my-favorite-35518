Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  root to: 'test#index'
  ActiveAdmin.routes(self)
end
