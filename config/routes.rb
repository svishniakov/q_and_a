Rails.application.routes.draw do
  get 'attachments/destroy'

  devise_for :users
  get 'answer/index'

  resources :questions do
    resources :answers, shallow: true do
      patch :best, on: :member
    end
  end

  root 'questions#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
