Rails.application.routes.draw do
  resources :users do
    resources :posts
  end

  post 'auth/login', to: 'authentication#authenticate'

  post 'signup', to: 'users#signup'
end
