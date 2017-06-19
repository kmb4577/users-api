Rails.application.routes.draw do

  root to: 'application#home'

  resources :users do
    resources :posts
  end

  post 'auth/login', to: 'authentication#authenticate'

  post 'signup', to: 'users#signup'
end
