Rails.application.routes.draw do
  devise_for :users,
  :controllers => {
    :sessions => "users/sessions"
  },
  :path => "",
  :path_names => {
    :sign_in  => "login",
  }

  devise_scope :user do
    get "/sign_out", to: "devise/sessions#destroy", as: :signout

    authenticated :user do
      # default route
      root "working_weeks#index", as: :authenticated_root

      # profile routes
      get :profile, to: "profile#show"
      put :profile, to: "profile#update"

      resources :users

      resources :shifts do
        scope module: :shift do
          resources :availables
          resources :confirmations
        end
        collection do
          get :options
        end
      end

      resources :working_weeks do
        scope module: :working_week do
          resources :available_shifts
          resources :confirmed_shifts
        end
        collection do
          get :options
        end
      end

      resources :services do
        member do
          get :available_shifts
        end
      end
    end
    unauthenticated do
      root "users/sessions#new", as: :unauthenticated_root

      get "*path" => redirect("/")
    end
  end
end