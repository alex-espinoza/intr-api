IntrApi::Application.routes.draw do
  devise_for :users, skip: [:sessions, :passwords, :registrations]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post 'sessions' => 'sessions#create', :as => 'login'
      end
    end
  end
end
