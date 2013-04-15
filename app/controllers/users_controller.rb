class UsersController < ApplicationController
  before_filter :logged_in, :only => [:answer_question]
  before_filter :survey_says, :only => [:show]
  def new
    @user = User.new
  end

  def create
    user = User.new( params[:user] )
    if user.save
      user.interest = Interest.create
      user.save
      @user = user
    else
      flash[:notice] = 'Something went wrong.'
      flash[:notice] = 'Username already exists!' if User.where( username: params[:user][:username] ).first
      @user = User.new
    end
  end

  def show
    @user = User.find( params[:id] )
    if @user = @auth
      render :show
    else
      redirect_to root_path
    end
    lat = @user.lat
    lon = @user.lon
    location = @user.location.split(' ').join()
    topic = "healthcare"
    #@user.careers.last.title.split(' ').first
    url = "https://api.meetup.com/find/groups?key=3141755d2b143b6963614c186b75c5d&sign=true&zip=07030&text=#{topic}&page=20"
    response = HTTParty.get("https://api.meetup.com/find/groups.json?key=3141755d2b143b6963614c186b75c5d&sign=true&text=#{topic}&location=#{location}&page=20")
    response = HTTParty.get(url)
    binding.pry
  end

  def answer_question
    params[:questions].each do |answer|
      q = Question.find(answer[0])
      @auth.questions << q
      Question.up_score(@auth, q.topic, answer[1][0].to_i)
    end
  end

  private
  def survey_says
    redirect_to(survey_path) if !@auth.ready_for_graph
  end
end