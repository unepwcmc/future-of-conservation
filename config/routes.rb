Rails.application.routes.draw do
  get 'static_pages/index'
  get 'results/:uuid', to: 'results#show', as: 'results'

  resources :answer_sets, only: [:create]
  resources :questions

  get 'survey/new', to: 'survey#index', as: 'new_survey'

  root 'static_pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
