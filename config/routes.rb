Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get 'products/:id' => 'products#show', as: :show_product
  root "pages#home"
  get '/about', to:'pages#about'
  resources :todos
  resources :products
  resources :pages
  resources :recipes do 
    resources :comments, only: [:create]
  end
  resources :ingredients, except: [:destroy]
  
  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #config real--time
  mount ActionCable.server => '/cable'
end
