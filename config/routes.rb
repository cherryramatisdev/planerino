# frozen_string_literal: true

Rails.application.routes.draw do
  resources :debits
  resources :months

  get '/debits/update_paid/:id', to: 'debits#update_paid', as: :update_paid

  root 'months#index'
end
