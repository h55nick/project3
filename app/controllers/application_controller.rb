class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authentication

  private
  def authentication
    @auth = User.find( session[:user_id] ) if session[:user_id]
  end

  def logged_in
    redirect_to(root_path) && (session[:user_id] = nil) if session[:user_id].nil?
  end

  def survey_completed
    redirect_to(root_path) if @auth && (@auth.questions.length == Question.all.length)
  end
end
