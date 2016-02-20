Rails.application.routes.draw do
  devise_for :users
 resources :pins do
  resources :comments
  member do
  put "like", to: "pins#upvote"
  put "unlike", to: "pins#unvote"

  end
end

  get "my", to: "pins#show_my"



 root "pins#index"
end
