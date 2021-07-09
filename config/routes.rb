Rails.application.routes.draw do
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => {sessions: 'devise/cas_sessions' }

  resources :todos do
    collection do
      put 'update_status/:id', to: 'todos#update_status', as: 'update_status'
    end
  end
  resources :accounts
end
