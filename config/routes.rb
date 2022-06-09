Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/users/:user_id/posts', to: 'posts#index'
  get '/posts/:id/edit', to: 'posts#edit'
  post '/posts/:id/edit', to: 'posts#update'
  get '/posts/new', to: 'posts#new'
  post '/posts/new', to: 'posts#create'
  get '/users/:user_id/posts/:id', to: 'posts#show'
  # get '/users/:user_id/posts/:post_id/comments/:id/edit', to: 'comments#index'
  get '/users/:user_id/posts/:post_id/comments/new', to: 'comments#new'
  post '/users/:user_id/posts/:post_id/comments/new', to: 'comments#create'
  get '/users', to: 'users#index'
  get '/', to: 'users#index'
  get '/users/:id', to: 'users#show'
  # Defines the root path route ("/")
  # root "articles#index"
end
