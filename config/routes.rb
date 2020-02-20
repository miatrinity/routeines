# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'routines#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :routines, except: %i[show] do
    resources :steps, only: %i[index new create edit update]
  end
end
