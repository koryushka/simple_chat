Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  resources :messages
  resources :sessions, only: [:create, :new, :destroy] do

  end

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
