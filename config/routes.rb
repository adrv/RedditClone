Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    member do
      post :vote
    end
  end
  
  root 'posts#index'

end
