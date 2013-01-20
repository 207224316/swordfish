Swordfish::Application.routes.draw do
  resources :items do
    resources :shares
  end

  resources :teams do
    resources :memberships
    resources :invites
  end

  get 'invite/:token' => 'invites#accept', :as => :accept_invite

  resources :users do
    collection do
      get :lookup
    end
  end

  namespace :auth do
    resource :rsa, :only => [:create, :update], :controller => 'rsa'
  end

  match 'mockup', :to => 'dashboard#mockup'
  root :to => 'dashboard#index'
end
