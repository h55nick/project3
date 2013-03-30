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

  resources :careers, :only => [:index, :show] do
    collection do
      get :zone_filter
      post :add_career
      delete :remove_career
      get '/mycareer' => 'careers#mycareers'
      get '/search/' => 'careers#search_jobs'
    end
  end

end
