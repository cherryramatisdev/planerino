# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :debits
  resources :months

  get '/debits/update_paid/:id', to: 'debits#update_paid', as: :update_paid

  get '/owner/get_debit_total/:id', to: 'owner#get_total', as: :get_debit_total_per_owner
  get '/debit/get_debit_total', to: 'debits#get_total', as: :get_debit_total

  root 'months#index'
end
