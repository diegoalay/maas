Rails.application.routes.draw do
  resources :services
  devise_for :users,
  :controllers => {
    :sessions => "users/sessions"
  },
  :path => "",
  :path_names => {
    :sign_in  => 'login',
  }

  devise_scope :user do
    get '/sign_out', to: 'devise/sessions#destroy', as: :signout

    authenticated :user do
      # default route
      root 'dashboard#show', as: :authenticated_root

      get :dashboard, to: "dashboard#show"

      # profile routes
      get :profile, to: "profile#show"
      put :profile, to: "profile#update"

      # employees
      resources :employees
    end

    unauthenticated do
      root 'users/sessions#new', as: :unauthenticated_root

      get '*path' => redirect('/')
    end
  end
end