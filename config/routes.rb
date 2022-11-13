# frozen_string_literal: true

Rails.application.routes.draw do
  resources :months
  root "months#index"
end
