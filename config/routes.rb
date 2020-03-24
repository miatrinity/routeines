# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'routines#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :routines, except: %i[show] do
    resources :steps, except: %i[show]
    resources :routine_flows, only: %i[show create]
  end

end
