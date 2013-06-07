class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :survey_says, :only => [:show]

  def new
    redirect_to survey_path
  end

  def show
    @user = User.find( params[:id] )
    if @user = current_user
      render :show
    else
      redirect_to root_path
    end
  end

  def answer_question
    params[:questions].each do |answer|
      q = Question.find(answer[0])
      current_user.questions << q
      Question.up_score(current_user, q.topic, answer[1][0].to_i)
    end
  end

  def extra
    current_user.update_attributes( location: params[:location], education: params[:education] )
    current_user.interest = Interest.new
    current_user.save
  end

  private
  def survey_says
    redirect_to(survey_path) if user_signed_in? && !current_user.ready_for_graph
  end
end