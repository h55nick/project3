Project3::Application.routes.draw do
  root :to => 'welcome#index'
  get '/simple' => 'welcome#simple'
  get '/survey' => 'welcome#survey'
  post '/survey' => 'welcome#answer'
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  resources :users, :only => [:new, :create, :show] do
    collection do
      post '/answer' => 'users#answer_question'
    end
  end

  resources :careers, :only => [:index, :show] do
    collection do
      get :zone_filter
      post :add_career
      delete :remove_career
      get :more
      get '/mycareer' => 'careers#mycareers'
    end
  end

  resources :jobs, :only => [:index, :destroy] do
    collection do
      post :add
      get '/search/' => 'jobs#search_jobs'
    end
  end

end
