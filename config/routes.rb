Rails.application.routes.draw do
  get 'attachments/destroy'

  devise_for :users
  get 'answer/index'

  concern :voted do
    member do
      post :plus
      post :minus
      delete :clear_vote
    end
  end

  resources :questions do
    resources :answers, shallow: true do
      patch :best, on: :member
      concerns :voted
    end
    concerns :voted
  end

  resources :attachments, only: :destroy

  root 'questions#index'

  mount ActionCable.server => '/cable'
end
