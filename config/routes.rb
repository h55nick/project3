Project3::Application.routes.draw do
  root :to => 'welcome#index'
  get '/simple' => 'welcome#simple'

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'

  resources :users, :only => [:new, :create, :show] do
    collection do
      post '/answer' => 'users#answer_question'
    end
  end
<<<<<<< HEAD

  resources :careers, :only => [:index, :show] do
    collection do
      get :zone_filter
    end
  end
=======
  resources :careers, :only => [:show] do
    collection do
      get '/search_view' => 'careers#test_search'
      get '/search/' => 'careers#search_jobs'
    end
  end

>>>>>>> 789a20b0924d39eadd30239d593a842542ed0f3e
end
