Rails.application.routes.draw do
  resources :demographic_questions
  get 'static_pages/index'
  get 'results/:uuid', to: 'results#show', as: 'results'

  resources :answer_sets, only: [:create]
  resources :questions

  get 'survey/new', to: 'survey#index', as: 'new_survey'

  root 'static_pages#index'

  get '/about', to: 'static_pages#about', as: 'about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
