require 'sidekiq/web'

Rails.application.routes.draw do
  resources :demographic_questions
  get 'static_pages/index'
  get 'results/:uuid', to: 'results#show', as: 'results'
  post 'export', to: 'results#export', as: 'export_results'

  resources :answer_sets, only: [:create]
  resources :questions
  resources :results, only: [:index]

  get 'survey/new', to: 'survey#index', as: 'new_survey'

  root 'static_pages#index'

  get '/about-the-project', to: 'static_pages#about_the_project', as: 'about_the_project'
  get '/about-the-debate',  to: 'static_pages#about_the_debate',  as: 'about_the_debate'

  # Protect sidekiq dash endpoint
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["ADMIN_USERNAME"])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["ADMIN_PASSWORD"]))
  end

  mount Sidekiq::Web, at: "/sidekiq"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
