class SessionController < ApplicationController
  before_filter :logged_in, only: [:destroy]

  def new
  end

  def create
    user = User.where( email: params[:email] ).first
    if user.present? && user.authenticate( params[:password] )
      session[:user_id] = user.id
    else
      session[:user_id] = nil
    end
    redirect_to(user)
  end

  def destroy
    session[:user_id] = nil
    @auth = nil
    redirect_to(root_path)
  end
end