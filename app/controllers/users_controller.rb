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
end