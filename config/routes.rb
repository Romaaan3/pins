Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :pins do
    resources :comments
    member do
    put "like", to: "pins#upvote"
    put "unlike", to: "pins#unvote"

    end
  end

  get "my", to: "pins#show_my"
  delete "del", to: "pins#delete_my"

  root "pins#index"

devise_scope :user do
  delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session_omni
end
end
