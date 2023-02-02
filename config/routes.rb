# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :debits
  resources :months
  resources :years

  get '/debits/update_paid/:id', to: 'debits#update_paid', as: :update_paid

  get '/owner/get_debit_total/:id', to: 'owner#total', as: :get_debit_total_per_owner
  get '/debit/get_debit_total', to: 'debits#total', as: :get_debit_total

  root 'years#index'
end
