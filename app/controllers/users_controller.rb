class UsersController < ApplicationController
  before_filter :logged_in, except: [:new, :create]
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
  end

  def answer_question
    params[:questions].each do |answer|
      q = Question.find(answer[0])
      @auth.questions << q
      Question.up_score(@auth, q.topic, answer[1][0].to_i)
    end
  end
end