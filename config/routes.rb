# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'routines#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :routines, except: %i[show] do
    resources :steps, except: %i[show]
    resources :routine_flows, only: %i[show create update destroy]
  end

  get 'routines/:id/report', to: 'routine_flow_report#index', as: :routine_flow_reports
  get 'routines/:id/report/:routine_flow_id', to: 'routine_flow_report#show', as: :routine_flow_report
end
