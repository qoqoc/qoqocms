Qoqocms::Engine.routes.draw do
  # clearance routes
  resources :passwords, :controller => 'clearance/passwords', :only => [:create, :new]

  resource  :session, :controller => 'clearance/sessions', :only => [:create, :new, :destroy]

  resources :users, :controller => 'clearance/users', :only => [:create, :new] do
    resource :password, :controller => 'clearance/passwords', :only => [:create, :edit, :update]
  end

  match 'sign_in' => 'clearance/sessions#new', :as => 'sign_in'
  match 'sign_out' => 'clearance/sessions#destroy', :as => 'sign_out', :via => :delete
  # match 'sign_up' => 'clearance/users#new', :as => 'sign_up'

  resources :user_requests, :only => [ :index, :create ]

  namespace :admin do
    mount RedactorRails::Engine => '/redactor_rails'

    resources :pages do
      post :order, on: :member
    end
    resources :settings
    resources :user_requests, :only => [:index, :show, :destroy]

    root :to => 'pages#index'
  end

  match '/:url' => 'pages#index', :constraints => {:url => /.*/}

  root :to => "pages#index"
end
