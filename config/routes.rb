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
      get :filter
      get :career_info
      post :add_career
      delete :remove_career
      get :more
      get '/mycareer' => 'careers#mycareers'
    end
  end

  #### JOB RESOURCES ######
  resources :jobs, :only => [:index, :destroy] do
    collection do
      post :add
      post :apply
      get :import
      get '/search/' => 'jobs#search_jobs'
    end
  end

  #### MEETUP RESOURCES ####

  #AJAX Call for User_dashboard
  get '/meetups' => 'meetups#get_meetups'
  #this could be done on browser side with more time.


  #### LINKEDIN OAuth #######
  get '/oauth/login' => 'linkedin#index'
  get '/oauth/callback'=> 'linkedin#callback'
end
