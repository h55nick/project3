class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new( params[:user] )
    if user.save
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
      # CHANGE TO AUTH LATER
      User.first.questions << q
      Question.up_score(User.first, q.topic, answer[1][0].to_i)
      User.first.total += 5
      User.first.save
    end
    binding.pry

  end
end