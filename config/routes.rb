Rails.application.routes.draw do
  resources :answer_sets, only: [:create]
  resources :questions
  root 'survey#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
