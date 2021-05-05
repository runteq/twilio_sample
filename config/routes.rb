Rails.application.routes.draw do
  root 'messages#index'
  resources :messages
  post '/messages/:id', to: 'messages#update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
