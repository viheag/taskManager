# config/routes.rb

Rails.application.routes.draw do
  resources :users do
    resources :notes, only: [:index, :create]
  end

  resources :notes, only: [:show, :update, :destroy]
end
