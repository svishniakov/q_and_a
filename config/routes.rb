Rails.application.routes.draw do
  devise_for :users
  get 'answer/index'

  resources :questions do
    resources :answers, shallow: true
  end

  root 'questions#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
