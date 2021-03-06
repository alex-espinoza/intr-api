IntrApi::Application.routes.draw do
  devise_for :users, skip: [:sessions, :passwords, :registrations]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :show, :edit, :update] do
        resources :internships, only: [:index, :show, :update]
      end
      devise_scope :user do
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
        post 'registrations' => 'registrations#create', :as => 'register'
      end
    end
  end
end
