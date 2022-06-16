Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'users#index'
  get '/users/:user_id/posts', to: 'posts#index'
  get '/users/:user_id/posts/page/:page_no', to: 'posts#index'
  delete '/posts/:id/delete', to: 'posts#delete'
  get '/posts/:id/edit', to: 'posts#edit'
  post '/posts/:id/edit', to: 'posts#update'
  get '/posts/new', to: 'posts#new'
  post '/posts/new', to: 'posts#create'
  get '/users/:user_id/posts/:id', to: 'posts#show'
  post '/users/:user_id/posts/:id/like_toggle', to: 'posts#like_toggle'
  get '/users/:user_id/posts/:post_id/comments/new', to: 'comments#new'
  post '/users/:user_id/posts/:post_id/comments/new', to: 'comments#create'
  delete '/users/:user_id/posts/:post_id/comments/:id/delete', to: 'comments#delete'
  get '/users', to: 'users#index'
  get '/', to: 'users#index'
  get '/users/:id', to: 'users#show'
  # Defines the root path route ("/")
  # root "articles#index"
end
