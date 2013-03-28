Project3::Application.routes.draw do
  root :to => 'welcome#index'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'
  resources :users, :only => [:new, :create, :show]
end
