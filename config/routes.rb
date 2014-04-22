IntrApi::Application.routes.draw do
  devise_for :users, skip: [:sessions, :passwords, :registrations]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post 'sessions' => 'sessions#create', :as => 'login'
        delete 'sessions' => 'sessions#destroy', :as => 'logout'
      end
    end
  end
end
